import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var cardView: UIView!
    @IBOutlet weak var favoriteImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var spinButton: UIButton!

    private let favorites = FavoritesData.all
    private var currentIndex: Int?

    override func viewDidLoad() {
        super.viewDidLoad()
        cardView.layer.cornerRadius = 24
        cardView.layer.shadowColor = UIColor.black.cgColor
        cardView.layer.shadowOpacity = 0.12
        cardView.layer.shadowRadius = 16
        cardView.layer.shadowOffset = CGSize(width: 0, height: 8)

        favoriteImageView.contentMode = .scaleAspectFit
        favoriteImageView.layer.cornerRadius = 18
        favoriteImageView.clipsToBounds = true

        spinButton.layer.cornerRadius = 16
        spinButton.clipsToBounds = true
    }

    @IBAction func spinTapped(_ sender: UIButton) {
        guard let index = randomIndex() else { return }
        currentIndex = index
        show(favorites[index])
        spinButton.setTitle("Spin again", for: .normal)
    }

    /// Returns a random index that is different from the one shown last.
    private func randomIndex() -> Int? {
        let candidates = favorites.indices.filter { $0 != currentIndex }
        return candidates.randomElement()
    }

    private func show(_ favorite: Favorite) {
        UIView.transition(with: cardView,
                          duration: 0.35,
                          options: .transitionFlipFromRight,
                          animations: {
            self.favoriteImageView.image = UIImage(named: favorite.imageName)
            self.titleLabel.text = favorite.title
            self.descriptionLabel.text = favorite.description
        })
    }
}
