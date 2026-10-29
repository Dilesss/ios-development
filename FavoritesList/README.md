# Favorite Desserts

UIKit app that shows my 20 favorite desserts in a `UITableView` with a custom cell
(image, title, subtitle, 5-star rating with SF Symbols).

- `FavoriteItem` — struct describing one dessert
- `FavoritesLibrary` — the list of items (one place)
- `FavoriteCell` — custom `UITableViewCell` with outlets only
- `ViewController` — `UITableViewDataSource`, dequeues `FavoriteCell`
- All layout is in `Main.storyboard` (stack views + Auto Layout)

## Screenshots

| iPhone SE (3rd gen) | iPhone 16 Pro Max |
|---|---|
| ![iPhone SE](Screenshots/iphone-se.png) | ![iPhone 16 Pro Max](Screenshots/iphone-16-pro-max.png) |

## Screen recording

[Scrolling through the list](Screenshots/scroll.mp4)
