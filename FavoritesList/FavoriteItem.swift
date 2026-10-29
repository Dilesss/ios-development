import Foundation

struct FavoriteItem {
    let title: String
    let subtitle: String
    let imageName: String
    let rating: Int   // 0...5
}

enum FavoritesLibrary {
    static let items: [FavoriteItem] = [
        FavoriteItem(title: "Tiramisu", subtitle: "Italy · coffee and mascarpone", imageName: "tiramisu", rating: 5),
        FavoriteItem(title: "Cheesecake", subtitle: "USA · cream cheese on a biscuit base", imageName: "cheesecake", rating: 5),
        FavoriteItem(title: "Baklava", subtitle: "Turkey · filo, nuts and honey", imageName: "baklava", rating: 4),
        FavoriteItem(title: "Macarons", subtitle: "France · almond meringue cookies", imageName: "macarons", rating: 4),
        FavoriteItem(title: "Churros", subtitle: "Spain · fried dough with chocolate", imageName: "churros", rating: 4),
        FavoriteItem(title: "Crème brûlée", subtitle: "France · custard with burnt sugar", imageName: "cremebrulee", rating: 5),
        FavoriteItem(title: "Brownie", subtitle: "USA · dense chocolate square", imageName: "brownie", rating: 4),
        FavoriteItem(title: "Chak-chak", subtitle: "Central Asia · fried dough in honey", imageName: "chakchak", rating: 5),
        FavoriteItem(title: "Napoleon cake", subtitle: "Puff pastry layers with custard", imageName: "napoleon", rating: 5),
        FavoriteItem(title: "Medovik", subtitle: "Honey cake with sour cream", imageName: "medovik", rating: 4),
        FavoriteItem(title: "Panna cotta", subtitle: "Italy · cooked cream with berries", imageName: "pannacotta", rating: 3),
        FavoriteItem(title: "Mochi", subtitle: "Japan · sweet rice cake", imageName: "mochi", rating: 3),
        FavoriteItem(title: "Apple strudel", subtitle: "Austria · apples rolled in thin dough", imageName: "strudel", rating: 4),
        FavoriteItem(title: "Pavlova", subtitle: "New Zealand · meringue with fruit", imageName: "pavlova", rating: 3),
        FavoriteItem(title: "Cinnamon roll", subtitle: "Sweden · soft bun with cinnamon", imageName: "cinnamonroll", rating: 5),
        FavoriteItem(title: "Gulab jamun", subtitle: "India · milk balls in syrup", imageName: "gulabjamun", rating: 2),
        FavoriteItem(title: "Lemon tart", subtitle: "France · lemon curd in shortcrust", imageName: "lemontart", rating: 4),
        FavoriteItem(title: "Red velvet cake", subtitle: "USA · cocoa sponge with cream cheese", imageName: "redvelvet", rating: 4),
        FavoriteItem(title: "Pastel de nata", subtitle: "Portugal · custard tart", imageName: "pasteldenata", rating: 5),
        FavoriteItem(title: "Chocolate fondant with a molten center and vanilla ice cream", subtitle: "France · warm cake, liquid inside", imageName: "fondant", rating: 1)
    ]
}
