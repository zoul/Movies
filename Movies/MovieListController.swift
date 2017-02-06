import UIKit
import MovieKit

let showDetailsSegueID = "showDetails"

class MovieListController: UITableViewController {

    var movies: [Movie] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "Popular Movies"
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        let request = MovieListRequest(apiKey: "XXX")
        request.send { result in
            switch result {
                case .success(let response):
                    print("Received \(response.results.count) items, displaying.")
                    DispatchQueue.main.async {
                        self.movies = response.results
                        self.tableView.reloadData()
                    }
                case .error(let msg):
                    print(msg)
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
