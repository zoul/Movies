import Foundation

// https://developers.themoviedb.org/3/movies/get-movie-details
//
// Note that while most (all?) of the fields are marked as optional
// in the spec, we treat them as required, since there’s not much to do
// with a movie without a title.
public struct Movie {

    public let id: Int
    public let title: String
    public let voteAverage: Float
    public let posterPath: String
    public let releaseDate: String
    public let overview: String
}

extension Movie: JSONDecodable {

    public init?(jsonObject: AnyObject) {
        guard let dict = jsonObject as? NSDictionary,
            let id = dict["id"] as? Int,
            let title = dict["title"] as? String,
            let voteAverage = dict["vote_average"] as? Float,
            let posterPath = dict["poster_path"] as? String,
            let overview = dict["overview"] as? String,
            let releaseDate = dict["release_date"] as? String
            else { return nil }
        self.init(id: id, title: title, voteAverage: voteAverage,
            posterPath: posterPath, releaseDate: releaseDate, overview: overview)
    }
}
