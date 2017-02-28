import UIKit
import MovieKit

public class MovieListController: UITableViewController {

    var movies: [Movie] = []
    public var didSelectMovie: (Movie) -> Void = { _ in }

    let dataSource = PagedMovieList()
    let lazyLoadTreshold = 10
    let cellID = "movie"

    let searchVC = UISearchController(searchResultsController: SearchResultsController())

    public override func viewDidLoad() {

        super.viewDidLoad()

        navigationItem.title = "Popular Movies"
        tableView.register(UINib(nibName: "MovieListCell", bundle: nil), forCellReuseIdentifier: cellID)

        searchVC.searchResultsUpdater = self
        searchVC.dimsBackgroundDuringPresentation = false
        tableView.tableHeaderView = searchVC.searchBar
        definesPresentationContext = true
        extendedLayoutIncludesOpaqueBars = true

        if let searchResultVC = searchVC.searchResultsController as? SearchResultsController {
            searchResultVC.didSelectMovie = { movie in
                self.didSelectMovie(movie)
            }
        }
    }

    public override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        if movies.count == 0 {
            loadNextPage()
        }
    }

    func loadNextPage() {
        dataSource.loadOneMorePage { newItems in
            guard let newItems = newItems else { return }
            DispatchQueue.main.async {
                let insertedIndexes = self.movies.endIndex..<self.movies.endIndex+newItems.count
                let indexPaths = insertedIndexes.map { IndexPath(row: $0, section: 0) }
                self.movies.append(contentsOf: newItems)
                self.tableView.insertRows(at: indexPaths, with: .fade)
            }
        }
    }
}

// Searching
//
// There is an important interplay between lazy loading and search: What should we do
// when the user scrolls to the bottom of the filtered result list? There are three basic
// approaches: 1) Disable lazy loading in search, effectively only searching in loaded
// results. 2) Load another page of popular movies, regardless of the number of matching
// movies that pop up in the search results. This has the obvious drawback that we may
// have to load several pages worth of results before there is a single new movie in the
// table. 3) When arriving at the bottom of the search results table, load more movies
// until we have a whole page worth of new results.
//
// From the user’s point of view, the correct behaviour would be to search *all* popular
// movies, lazy loading more results. This wouldn’t work with the `/movie/popular` API call
// though, since we would have to implement the search by hand, iterating over all results &
// effectively DoSing the service. It would be better implemented using the `/search/movie`
// API call, but that doesn’t allow us to filter the results down to popular movies, again
// doing something unexpected for the user.
//
// As it is, the simple solution here is to use the approach #1, just filtering already
// loaded results.
extension MovieListController: UISearchResultsUpdating {

    public func updateSearchResults(for searchController: UISearchController) {
        if let resultVC = searchVC.searchResultsController as? SearchResultsController {
            let query = searchVC.searchBar.text?.lowercased() ?? ""
            resultVC.movies = movies.filter { $0.title.lowercased().contains(query) }
        }
    }
}

// Data Source
extension MovieListController {

    public override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    public override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return movies.count
    }

    public override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        // swiftlint:disable force_cast
        let cell = tableView.dequeueReusableCell(withIdentifier: cellID, for: indexPath) as! MovieListCell
        // If we are close to the bottom of the table, trigger loading more responses.
        if indexPath.row >= movies.count - lazyLoadTreshold {
            loadNextPage()
        }
        return cell
    }

    public override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
}

// Table Delegate
extension MovieListController {

    public override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        didSelectMovie(movies[indexPath.row])
    }

    public override func tableView(_ tableView: UITableView,
        willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if let cell = cell as? MovieListCell {
            cell.movie = movies[indexPath.row]
        }
    }
}
