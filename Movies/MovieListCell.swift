import UIKit
import MovieKit

class MovieListCell: UITableViewCell {

    @IBOutlet var titleLabel: UILabel!
    @IBOutlet var ratingLabel: UILabel!
    @IBOutlet var thumbnailView: UIImageView!

    var movie: Movie? = nil {
        didSet {
            if let movie = movie {
                titleLabel.text = movie.title
                ratingLabel.text = String(format: "%0.2f / 10", movie.voteAverage)
                loadMovieImage()
            } else {
                titleLabel.text = ""
                ratingLabel.text = ""
                thumbnailView.image = nil
            }
        }
    }

    private var contentVersion = 0

    override func awakeFromNib() {
        super.awakeFromNib()
        let layer = thumbnailView.layer
        layer.cornerRadius = 22
        layer.masksToBounds = true
    }

    override func prepareForReuse() {
        super.prepareForReuse()
        contentVersion += 1
        movie = nil
    }

    private func loadMovieImage() {
        guard let imageURL = movie?.iconURL else { return }
        let lastSeenVersion = contentVersion
        UIImage.cachedImage(withURL: imageURL) { image in
            if self.contentVersion == lastSeenVersion {
                self.thumbnailView.image = image
            }
        }
    }
}
