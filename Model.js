.pragma library

// Soundscape catalog. `id` doubles as the .ogg filename (without extension)
// under sounds/. `moods` drives the Work/Play/Sleep filter row.
var soundscapes = [
  { id: "ocean-waves", label: "Ocean Waves", icon: "🌊", moods: ["play", "sleep"] },
  { id: "coffee-shop", label: "Coffee Shop", icon: "☕", moods: ["work"] },
  { id: "restaurant", label: "Restaurant", icon: "🍽️", moods: ["work", "play"] },
  { id: "tokyo-night", label: "Tokyo Night", icon: "🌃", moods: ["work", "play"] },
  { id: "fireplace", label: "Fireplace", icon: "🔥", moods: ["play", "sleep"] },
  { id: "highway", label: "Highway", icon: "🚗", moods: ["work"] },
  { id: "forest-night", label: "Night Woods", icon: "🌲", moods: ["sleep", "play"] },
  { id: "rain", label: "Rain", icon: "🌧️", moods: ["work", "sleep"] },
  { id: "thunderstorm", label: "Thunderstorm", icon: "⛈️", moods: ["sleep", "play"] },
  { id: "library", label: "Library", icon: "📚", moods: ["work"] },
  { id: "train", label: "Train", icon: "🚆", moods: ["work", "play"] },
  { id: "birdsong", label: "Birdsong", icon: "🐦", moods: ["work", "play"] }
]

var moods = [
  { id: "all", label: "All" },
  { id: "work", label: "Work" },
  { id: "play", label: "Play" },
  { id: "sleep", label: "Sleep" }
]

function visibleSoundscapes(mood) {
  if (!mood || mood === "all") return soundscapes
  var out = []
  for (var i = 0; i < soundscapes.length; i++) {
    if (soundscapes[i].moods.indexOf(mood) >= 0) out.push(soundscapes[i])
  }
  return out
}

function soundscapeById(id) {
  for (var i = 0; i < soundscapes.length; i++) {
    if (soundscapes[i].id === id) return soundscapes[i]
  }
  return null
}
