import UIKit
import MovieKit

class MovieListController: UITableViewController {

    var movies: [Movie] = []
    let dataSource = PagedMovieList()
    let lazyLoadTreshold = 10
    let cellID = "movie"

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "Popular Movies"
        tableView.register(UINib(nibName: "MovieListCell", bundle: nil), forCellReuseIdentifier: cellID)
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        if movies.count == 0 {
            loadNextPage()
        }
    }

    func loadNextPage() {
        dataSource.loadOneMorePage { newItemCount in
            guard newItemCount > 0 else { return }
            DispatchQueue.main.async {
                let insertedIndexes = self.movies.endIndex..<self.movies.endIndex+newItemCount
                let indexPaths = insertedIndexes.map { IndexPath(row: $0, section: 0) }
                self.movies = self.dataSource.movies
                self.tableView.insertRows(at: indexPaths, with: .fade)
            }
        }
    }
}

// Data Source
extension MovieListController {

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return movies.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        let cell = tableView.dequeueReusableCell(withIdentifier: cellID, for: indexPath) as! MovieListCell
        if indexPath.row >= movies.count - lazyLoadTreshold {
            loadNextPage()
        }
        return cell
    }

    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
}

// Table Delegate
extension MovieListController {

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let detailVC = MovieDetailController(movie: movies[indexPath.row])
        navigationController?.pushViewController(detailVC, animated: true)
    }

    override func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if let cell = cell as? MovieListCell {
            cell.movie = movies[indexPath.row]
        }
    }
}
