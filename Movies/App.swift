import UIKit
import MovieKit

final class App {

    let navigationVC: UINavigationController

    init() {
        navigationVC = App.buildNavigationVC()
        let movieListVC = MovieListController()
        movieListVC.didSelectMovie = displayMovieDetail
        navigationVC.viewControllers = [movieListVC]
    }

    func displayMovieDetail(movie: Movie) {
        let detailVC = MovieDetailController(movie: movie)
        navigationVC.pushViewController(detailVC, animated: true)
    }

    private class func buildNavigationVC() -> UINavigationController {
        let vc = UINavigationController()
        let navBar = vc.navigationBar
        navBar.barTintColor = UIColor(colorLiteralRed: 0, green: 175/255, blue: 1, alpha: 0)
        navBar.tintColor = UIColor.white
        navBar.titleTextAttributes = [NSForegroundColorAttributeName: UIColor.white]
        navBar.isTranslucent = false
        return vc
    }
}
