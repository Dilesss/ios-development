import UIKit

final class ViewController: UIViewController, UITableViewDataSource {
    @IBOutlet weak var tableView: UITableView!

    private let items = FavoritesLibrary.items
    private let cellIdentifier = "FavoriteCell"

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        items.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as? FavoriteCell else {
            print("Cell with identifier \(cellIdentifier) is not a FavoriteCell")
            return UITableViewCell()
        }
        cell.configure(with: items[indexPath.row])
        return cell
    }
}
