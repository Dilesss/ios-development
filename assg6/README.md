# Food Roulette — Lab 6 · Favorites Roulette

A single-screen iOS app that shows a random card from my 10 favorite dishes.
Each tap on **Spin the roulette** flips the card and shows a new dish: an image, a title and a short description. The same dish never appears twice in a row.

**Category:** Food. The dishes are Beshbarmak, Plov, Manti, Baursak, Lagman, Pizza Margherita, Sushi, Ramen, Tiramisu and Pancakes.

## Tech
- iOS App template, Storyboard interface, Swift
- Layout in `Main.storyboard` with `UIImageView`, `UILabel`, `UIButton`. **No Auto Layout** (frames + autoresizing masks, zero constraints)
- Favorites are stored as an array of the `Favorite` struct (`Favorite.swift`)
- Images in `Assets.xcassets`, shown with `scaleAspectFit` so they are never stretched
- Custom `LaunchScreen.storyboard` and a custom 1024×1024 `AppIcon`
- No force unwraps except `@IBOutlet` declarations

## Run
Open `FavoritesRoulette.xcodeproj` in Xcode, choose an iPhone 16 simulator and press ⌘R.

## Screenshots

| Launch screen | Main screen | Home Screen icon |
|---|---|---|
| ![Launch screen](screenshots/launch.png) | ![Main screen](screenshots/main.png) | ![Home Screen](screenshots/home.png) |
