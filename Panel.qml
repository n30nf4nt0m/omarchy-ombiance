import QtQuick
import QtQuick.Layouts
import Quickshell
import Quickshell.Io
import qs.Ui
import qs.Commons
import "Model.js" as Model

Panel {
  id: root
  moduleName: "io.github.phillipelwood1.ombiance"
  ipcTarget: "io.github.phillipelwood1.ombiance"

  // Everything this plugin needs lives alongside this QML file, so resolve
  // our own directory instead of assuming anything is installed on PATH.
  readonly property string pluginDir: Qt.resolvedUrl(".").toString().replace("file://", "")
  readonly property string ctlScript: pluginDir + "scripts/ombiance-ctl"
  readonly property string soundsDir: pluginDir + "sounds/"

  property bool playing: false
  property bool paused: false
  property bool dragging: false
  property string currentCategory: ""
  property int volume: setting("volume", 70)
  property string activeMood: setting("mood", "all")

  readonly property var currentSoundscape: Model.soundscapeById(currentCategory)
  readonly property var visibleSoundscapes: Model.visibleSoundscapes(activeMood)
  readonly property string barIcon: root.playing && !root.paused ? "🎶" : "🎧"

  function persist(patch) {
    root.settings = Object.assign({}, root.settings, patch)
    if (root.bar && root.bar.shell) root.bar.shell.updateEntryInline(root.moduleName, root.settings)
  }

  function playSoundscape(id) {
    var sc = Model.soundscapeById(id)
    if (!sc || playProc.running) return
    playProc.command = [root.ctlScript, "play", sc.id, root.soundsDir + sc.id + ".ogg", String(root.volume)]
    playProc.running = true
  }

  function stopPlayback() {
    if (!root.playing || stopProc.running) return
    stopProc.running = true
  }

  function togglePause() {
    if (!root.playing || toggleProc.running) return
    toggleProc.running = true
  }

  function setVolume(v) {
    if (volumeProc.running) return
    volumeProc.command = [root.ctlScript, "volume", String(v)]
    volumeProc.running = true
  }

  function setMood(id) {
    root.activeMood = id
    persist({ mood: id })
  }

  function refreshStatus() {
    if (statusProc.running) return
    statusProc.running = true
  }

  function applyStatus(raw) {
    var data
    try { data = JSON.parse(raw) } catch (e) { return }
    root.playing = !!data.playing
    root.paused = !!data.paused
    root.currentCategory = data.category || ""
    if (!root.dragging && typeof data.volume === "number") root.volume = data.volume
  }

  Component.onCompleted: refreshStatus()

  Process {
    id: playProc
    onExited: function(exitCode) {
      if (exitCode !== 0) Quickshell.execDetached(["omarchy-notification-send", "Ombiance: couldn't start that soundscape"])
      root.refreshStatus()
    }
  }

  Process {
    id: stopProc
    command: [root.ctlScript, "stop"]
    onExited: root.refreshStatus()
  }

  Process {
    id: toggleProc
    command: [root.ctlScript, "toggle-pause"]
    onExited: root.refreshStatus()
  }

  Process {
    id: volumeProc
  }

  Process {
    id: statusProc
    command: [root.ctlScript, "status"]
    stdout: StdioCollector {
      waitForEnd: true
      onStreamFinished: root.applyStatus(text)
    }
  }

  // Keeps the bar icon/tooltip honest if playback is stopped or fails from
  // outside this popup (e.g. mpv crashing, or the socket going stale).
  Timer {
    interval: 4000
    running: true
    repeat: true
    onTriggered: root.refreshStatus()
  }

  implicitWidth: button.implicitWidth
  implicitHeight: button.implicitHeight

  BarIconButton {
    id: button
    anchors.fill: parent
    bar: root.bar
    text: root.barIcon
    tooltipText: root.currentSoundscape ? root.currentSoundscape.label : "Ombiance"
    onPressed: function(b) {
      if (b === Qt.RightButton) root.togglePause()
      else if (b === Qt.MiddleButton) root.stopPlayback()
      else root.toggle()
    }
  }

  KeyboardPanel {
    id: panel
    anchorItem: button
    owner: root
    bar: root.bar
    open: root.opened
    contentWidth: panel.fittedContentWidth(Style.space(320))
    contentHeight: panel.fittedContentHeight(column.implicitHeight)

    onOpenChanged: if (open) root.refreshStatus()

    Column {
      id: column
      anchors.left: parent.left
      anchors.right: parent.right
      anchors.top: parent.top
      spacing: Style.space(14)

      // ---------- Hero ----------
      Item {
        width: parent.width
        implicitHeight: Math.max(heroIcon.implicitHeight, heroLabels.implicitHeight)

        Text {
          id: heroIcon
          textFormat: Text.PlainText
          text: root.barIcon
          color: root.bar.foreground
          font.family: root.bar.fontFamily
          font.pixelSize: Style.font.display
          anchors.left: parent.left
          anchors.verticalCenter: parent.verticalCenter
        }

        Column {
          id: heroLabels
          anchors.left: heroIcon.right
          anchors.leftMargin: Style.space(14)
          anchors.right: parent.right
          anchors.verticalCenter: parent.verticalCenter
          spacing: Style.space(2)

          Text {
            text: "Ombiance"
            color: root.bar.foreground
            font.family: root.bar.fontFamily
            font.pixelSize: Style.font.title
            font.bold: true
          }

          Text {
            textFormat: Text.PlainText
            text: root.playing
              ? (root.currentSoundscape ? root.currentSoundscape.label.toUpperCase() + (root.paused ? " · PAUSED" : "") : "PLAYING")
              : "NOT PLAYING"
            color: Qt.darker(root.bar.foreground, 1.4)
            font.family: root.bar.fontFamily
            font.pixelSize: Style.font.caption
            font.bold: true
            font.letterSpacing: 1.2
          }
        }
      }

      // ---------- Mood filter ----------
      Row {
        id: moodRow
        width: parent.width
        spacing: Style.space(6)

        readonly property real cellWidth: (width - spacing * (Model.moods.length - 1)) / Model.moods.length

        Repeater {
          model: Model.moods
          Button {
            required property var modelData
            width: moodRow.cellWidth
            text: modelData.label
            fontSize: Style.font.bodySmall
            foreground: root.bar.foreground
            fontFamily: root.bar.fontFamily
            horizontalPadding: Style.spacing.controlPaddingX
            verticalPadding: Style.spacing.controlPaddingY
            bordered: true
            active: root.activeMood === modelData.id
            onClicked: root.setMood(modelData.id)
          }
        }
      }

      PanelSeparator { foreground: root.bar.foreground }

      // ---------- Soundscapes ----------
      PanelSectionHeader {
        text: "SOUNDSCAPES"
        foreground: root.bar.foreground
        fontFamily: root.bar.fontFamily
      }

      Flow {
        width: parent.width
        spacing: Style.space(8)

        Repeater {
          model: root.visibleSoundscapes
          Button {
            required property var modelData
            iconText: modelData.icon
            text: modelData.label
            iconSize: Style.font.title
            fontSize: Style.font.bodySmall
            foreground: root.bar.foreground
            fontFamily: root.bar.fontFamily
            horizontalPadding: Style.spacing.controlPaddingX
            verticalPadding: Style.spacing.controlPaddingY + Style.space(2)
            bordered: true
            active: root.playing && root.currentCategory === modelData.id
            onClicked: root.playSoundscape(modelData.id)
          }
        }
      }

      PanelSeparator { foreground: root.bar.foreground }

      // ---------- Transport ----------
      Row {
        width: parent.width
        spacing: Style.space(8)

        Button {
          iconText: root.paused ? "▶" : "⏸"
          iconSize: Style.font.title
          foreground: root.bar.foreground
          fontFamily: root.bar.fontFamily
          horizontalPadding: Style.spacing.controlPaddingX
          verticalPadding: Style.spacing.controlPaddingY
          bordered: true
          enabled: root.playing
          opacity: root.playing ? 1.0 : 0.4
          onClicked: root.togglePause()
        }

        Button {
          iconText: "⏹"
          iconSize: Style.font.title
          foreground: root.bar.foreground
          fontFamily: root.bar.fontFamily
          horizontalPadding: Style.spacing.controlPaddingX
          verticalPadding: Style.spacing.controlPaddingY
          bordered: true
          enabled: root.playing
          opacity: root.playing ? 1.0 : 0.4
          onClicked: root.stopPlayback()
        }
      }

      RowLayout {
        width: parent.width
        spacing: Style.space(10)

        Text {
          text: "🔊"
          color: root.bar.foreground
          font.family: root.bar.fontFamily
          font.pixelSize: Style.font.body
        }

        PanelSlider {
          id: volumeSlider
          Layout.fillWidth: true
          bar: root.bar
          minimum: 0
          maximum: 100
          integer: true
          value: root.volume
          onMoved: function(v) {
            root.dragging = true
            root.volume = Math.round(v)
          }
          onReleased: function(v) {
            root.dragging = false
            var vi = Math.round(v)
            root.volume = vi
            root.setVolume(vi)
            root.persist({ volume: vi })
          }
        }

        Text {
          text: root.volume + "%"
          color: root.bar.foreground
          font.family: root.bar.fontFamily
          font.pixelSize: Style.font.bodySmall
          Layout.preferredWidth: Style.space(34)
        }
      }
    }
  }
}
