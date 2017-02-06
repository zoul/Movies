import UIKit
import MovieKit

class MovieListController: UITableViewController {

    var movies: [Movie] = []
    let dataSource = PagedMovieList()
    let lazyLoadTreshold = 10

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "Popular Movies"
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        if movies.count == 0 {
            loadNextPage()
        }
    }

    func loadNextPage() {
        dataSource.loadOneMorePage { _ in
            DispatchQueue.main.async {
                self.movies = self.dataSource.movies
                self.tableView.reloadData()
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

        let cellID = "movie"
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: cellID)
        let cell = tableView.dequeueReusableCell(withIdentifier: cellID, for: indexPath)
        let movie = movies[indexPath.row]
        cell.textLabel?.text = movie.title

        if indexPath.row >= movies.count - lazyLoadTreshold {
            loadNextPage()
        }

        return cell
    }
}

// Table Delegate
extension MovieListController {

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let detailVC = MovieDetailController(movie: movies[indexPath.row])
        navigationController?.pushViewController(detailVC, animated: true)
    }
}