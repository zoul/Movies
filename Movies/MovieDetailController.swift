import UIKit
import MovieKit

public class MovieDetailController: UIViewController {

    let movie: Movie

    @IBOutlet var posterImageView: UIImageView!
    @IBOutlet var releaseDateLabel: UILabel!
    @IBOutlet var ratingLabel: UILabel!
    @IBOutlet var synopsisTextView: UITextView!

    public init(movie: Movie) {
        self.movie = movie
        super.init(nibName: nil, bundle: Bundle(for: MovieDetailController.self))
    }

    public required init?(coder aDecoder: NSCoder) {
        fatalError("Not supported")
    }

    public override func viewDidLoad() {
        super.viewDidLoad()

        navigationItem.title = movie.title
        edgesForExtendedLayout = []

        releaseDateLabel.text = "Released: \(movie.releaseDate)"
        ratingLabel.text = String(format: "Average Vote: %0.2f of 10", movie.voteAverage)
        synopsisTextView.text = movie.overview
    }

    public override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        if let backdropURL = movie.backdropURL {
            UIImage.cachedImage(withURL: backdropURL) { image in
                guard let image = image else { return }
                self.posterImageView.setImageAnimated(image: image)
            }
        }
    }
}

private extension UIImageView {

    func setImageAnimated(image: UIImage) {
        UIView.transition(with: self, duration: 0.2, options: .transitionCrossDissolve, animations: {
            self.image = image
        }, completion: nil)
    }
}
