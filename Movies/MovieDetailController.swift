import UIKit
import MovieKit

class MovieDetailController: UIViewController {

    let movie: Movie

    @IBOutlet var releaseDateLabel: UILabel!
    @IBOutlet var ratingLabel: UILabel!
    @IBOutlet var synopsisTextView: UITextView!

    init(movie: Movie) {
        self.movie = movie
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("Not supported")
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        navigationItem.title = movie.title
        edgesForExtendedLayout = []

        releaseDateLabel.text = "Released: \(movie.releaseDate)"
        ratingLabel.text = String(format: "Average Vote: %0.2f of 10", movie.voteAverage)
        synopsisTextView.text = movie.overview
    }
}
