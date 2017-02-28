import UIKit
import MovieKit

class SearchResultsController: UITableViewController {

    let cellID = "movie"

    var didSelectMovie: (Movie) -> Void = { _ in }
    var movies: [Movie] = [] {
        didSet {
            tableView.reloadData()
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        let bundle = Bundle(for: type(of: self))
        tableView.register(UINib(nibName: "MovieListCell", bundle: bundle), forCellReuseIdentifier: cellID)
    }
}

// Data Source
extension SearchResultsController {

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return movies.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // swiftlint:disable force_cast
        return tableView.dequeueReusableCell(withIdentifier: cellID, for: indexPath) as! MovieListCell
    }

    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
}

// Table Delegate
extension SearchResultsController {

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        didSelectMovie(movies[indexPath.row])
    }

    override func tableView(_ tableView: UITableView,
        willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if let cell = cell as? MovieListCell {
            cell.movie = movies[indexPath.row]
        }
    }
}
