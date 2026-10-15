import Foundation

struct Favorite {
    let imageName: String
    let title: String
    let description: String
}

enum FavoritesData {
    static let category = "Favorite Dishes"

    static let all: [Favorite] = [
        Favorite(imageName: "beshbarmak",
                 title: "Beshbarmak",
                 description: "Boiled meat over thin hand-cut noodles with onion sauce. The heart of every big Kazakh family dinner."),
        Favorite(imageName: "plov",
                 title: "Plov",
                 description: "Rice slow-cooked in a kazan with lamb, carrots, garlic and cumin. Better when someone else's grandma makes it."),
        Favorite(imageName: "manti",
                 title: "Manti",
                 description: "Large steamed dumplings filled with juicy minced meat and onion, served with sour cream."),
        Favorite(imageName: "baursak",
                 title: "Baursak",
                 description: "Golden fried dough puffs, soft inside. Perfect with tea, honey and a long conversation."),
        Favorite(imageName: "lagman",
                 title: "Lagman",
                 description: "Hand-pulled noodles with beef and peppers in a rich, spicy sauce. Great on a cold Almaty evening."),
        Favorite(imageName: "pizza",
                 title: "Pizza Margherita",
                 description: "Tomato, mozzarella and fresh basil on a thin, blistered crust. Simple and always right."),
        Favorite(imageName: "sushi",
                 title: "Sushi",
                 description: "Vinegared rice with fresh fish, a little wasabi and soy sauce. Best enjoyed one piece at a time."),
        Favorite(imageName: "ramen",
                 title: "Ramen",
                 description: "Deep, savory broth with springy noodles, a soft egg and green onions. Comfort food in a bowl."),
        Favorite(imageName: "tiramisu",
                 title: "Tiramisu",
                 description: "Coffee-soaked ladyfingers layered with mascarpone cream and cocoa. The dessert that ends every argument."),
        Favorite(imageName: "pancakes",
                 title: "Pancakes",
                 description: "A fluffy stack with butter and maple syrup. The best reason to wake up early on a weekend.")
    ]
}
