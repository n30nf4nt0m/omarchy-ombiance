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
  { id: "birdsong", label: "Birdsong", icon: "🐦", moods: ["work", "play"] },
  { id: "crickets", label: "Crickets", icon: "🦗", moods: ["sleep", "play"] },
  { id: "snowfall", label: "Snowfall", icon: "❄️", moods: ["sleep", "play"] },
  { id: "airport", label: "Airport", icon: "✈️", moods: ["work", "play"] },
  { id: "city-street", label: "City Street", icon: "🏙️", moods: ["work", "play"] },
  { id: "wind-chimes", label: "Wind Chimes", icon: "🎐", moods: ["play", "sleep"] },
  { id: "windy-day", label: "Windy Day", icon: "💨", moods: ["work", "sleep"] },
  { id: "subway-station", label: "Subway Station", icon: "🚇", moods: ["work", "play"] },
  { id: "arcade", label: "Arcade", icon: "🕹️", moods: ["play"] },
  { id: "brook", label: "Babbling Brook", icon: "🏞️", moods: ["work", "sleep"] },
  { id: "cat-purr", label: "Cat Purring", icon: "🐈", moods: ["sleep", "work"] },
  { id: "laundromat", label: "Laundromat", icon: "🧺", moods: ["work", "sleep"] },
  { id: "harbor-night", label: "Night Harbor", icon: "⚓", moods: ["sleep", "play"] },
  { id: "cat-cafe", label: "Cat Café", icon: "🐱", moods: ["work", "play"] },
  { id: "space-station", label: "Space Station", icon: "🛰️", moods: ["work", "sleep"] },
  { id: "bowling-alley", label: "Bowling Alley", icon: "🎳", moods: ["play"] },
  { id: "underwater", label: "Underwater", icon: "🫧", moods: ["sleep", "work"] },
  { id: "campsite-night", label: "Campsite", icon: "🏕️", moods: ["sleep", "play"] },
  { id: "barbershop", label: "Barbershop", icon: "💈", moods: ["work", "play"] }
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
