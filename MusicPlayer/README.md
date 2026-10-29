# Music Player

Single-screen music player in UIKit: cover, title, artist and Previous / Play-Pause / Next
controls. Plays 10 royalty-free tracks bundled with the app using `AVAudioPlayer`.

- `Track` — struct: title, artist, fileName, coverImageName
- `TrackLibrary` — the list of tracks (one place)
- `ViewController` — outlets, actions, `AVAudioPlayer`, `AVAudioPlayerDelegate`
- All layout is in `Main.storyboard`: a vertical root stack view (cover, labels stack,
  controls stack), pinned to the Safe Area with 20 pt margins and centered vertically;
  the cover has a 1:1 aspect ratio

Music: royalty-free tracks from Pixabay Music (replace with your source and track links).

## Screenshots

| iPhone SE (3rd gen) | iPhone 16 Pro Max |
|---|---|
| ![iPhone SE](Screenshots/iphone-se.png) | ![iPhone 16 Pro Max](Screenshots/iphone-16-pro-max.png) |

## Screen recording

[Play, pause, next, previous, wrap-around](Screenshots/demo.mp4)
