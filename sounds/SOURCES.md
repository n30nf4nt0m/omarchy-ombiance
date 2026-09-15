# Sound Sources

Provenance / attribution record for the ambient loops bundled with Ombiance.
All files were sourced from [Freesound.org](https://freesound.org) and are
licensed **CC0 1.0** (Creative Commons Zero / public domain dedication), so no
attribution is legally required — this table is kept anyway as a provenance
record.

| Category slug | File | Original source (Freesound page) | Author / uploader | License | Duration |
|---|---|---|---|---|---|
| ocean-waves | `ocean-waves.ogg` | [Waves crashing on shore](https://freesound.org/people/jamgypsy/sounds/795445/) | jamgypsy | CC0 1.0 | 2:07 |
| coffee-shop | `coffee-shop.ogg` | [Ambience Coffee Shop 1](https://freesound.org/people/JarredGibb/sounds/233280/) | JarredGibb | CC0 1.0 | 3:11 |
| restaurant | `restaurant.ogg` | [Restaurant ambience.WAV](https://freesound.org/people/DDT197/sounds/445787/) | DDT197 | CC0 1.0 | 2:00 |
| tokyo-night | `tokyo-night.ogg` | [city-night-rain-light.wav](https://freesound.org/people/ragamuffin/sounds/197213/) | ragamuffin | CC0 1.0 | 2:47 |
| fireplace | `fireplace.ogg` | [Crackling Fire](https://freesound.org/people/samarobryn/sounds/414767/) | samarobryn | CC0 1.0 | 1:00 |
| highway | `highway.ogg` | [AMB_Country_Town_Traffic.wav](https://freesound.org/people/conleec/sounds/159737/) | conleec | CC0 1.0 | 4:15 |
| forest-night | `forest-night.ogg` | [Forest At Night Ambience](https://freesound.org/people/fribergmusic2024/sounds/719558/) | fribergmusic2024 | CC0 1.0 | 0:31 |
| rain | `rain.ogg` | [Looping Rain On Skylight Foley Texture](https://freesound.org/people/deadrobotmusic/sounds/663947/) | deadrobotmusic | CC0 1.0 | 0:21 |
| thunderstorm | `thunderstorm.ogg` | [Rain and Thunderstorm](https://freesound.org/people/neolein/sounds/474256/) | neolein | CC0 1.0 | 8:46 |
| library | `library.ogg` | [Quiet library ambience](https://freesound.org/people/xkeril/sounds/620683/) | xkeril | CC0 1.0 | 9:40 |
| train | `train.ogg` | [Train Journey on inside.wav](https://freesound.org/people/Walter_Odington/sounds/26274/) | Walter_Odington | CC0 1.0 | 4:10 |
| birdsong | `birdsong.ogg` | [Birds in the Morning](https://freesound.org/people/myrinvp/sounds/472708/) | myrinvp | CC0 1.0 | 2:17 |

## Notes

- `tokyo-night.ogg`: no literal "Tokyo" recording with a CC0 license was found;
  used a substitute per the task brief — a light rain / quiet night city
  street ambience recording, which matches the intended vibe.
- `highway.ogg`: a recording of vehicle traffic passing through a small town
  (continuous road/engine noise, no horns/sirens) was chosen over shorter
  (10-47s) literal "highway"-tagged CC0 clips because it loops far less
  noticeably at 4:15.
- All files were downloaded from Freesound's HQ preview MP3 CDN
  (`cdn.freesound.org/previews/...`), then transcoded to Ogg Vorbis
  (`libvorbis -q:a 4`, 44.1kHz stereo) with ffmpeg for the plugin.
- Original license text observed on every source page: "Creative Commons 0"
  (CC0 1.0 Universal / Public Domain Dedication).
- `birdsong.ogg`: sourced from a recording described as "sunrise birdsong"
  captured at 4:30 AM; chosen because it reads as clearly daytime/morning
  birdsong (no owls, crickets, or other nocturnal ambience) to complement
  the existing `forest-night` category rather than duplicate it.
