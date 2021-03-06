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
    public let backdropPath: String
    public let releaseDate: String
    public let overview: String

    // This is a simplistic view of the image support offered by the backend,
    // see https://developers.themoviedb.org/3/getting-started/images for details.
    public var backdropURL: URL? {
        return URL(string: "https://image.tmdb.org/t/p/w500" + backdropPath)
    }

    public var iconURL: URL? {
        return URL(string: "https://image.tmdb.org/t/p/w75" + backdropPath)
    }
}

extension Movie : JSONDecodable {

    public init?(jsonObject: Any) {

        guard let dict = jsonObject as? NSDictionary,
            let id = dict["id"] as? Int,
            let title = dict["title"] as? String,
            let voteAverage = dict["vote_average"] as? Float,
            let backdropPath = dict["backdrop_path"] as? String,
            let overview = dict["overview"] as? String,
            let releaseDate = dict["release_date"] as? String
            else { return nil }

        self.id = id
        self.title = title
        self.voteAverage = voteAverage
        self.backdropPath = backdropPath
        self.overview = overview
        self.releaseDate = releaseDate
    }
}

extension Movie {

    public static func withID(_ id: Int) -> Resource<Movie> {
        return Resource(url: URL(string: "https://api.themoviedb.org/3/movie/\(id)")!)
    }

    public static func popular(pageNumber: Int = 1) -> Resource<MovieListPage> {
        return Resource(
            url: URL(string: "https://api.themoviedb.org/3/movie/popular")!,
            urlParams: ["page": String(pageNumber)]
        )
    }
}

extension Movie {

    public static let template = Movie(id: 157336, title: "Interstellar", voteAverage: 8.12,
        backdropPath: "/xu9zaAevzQ5nnrsXN6JcahLnG4i.jpg", releaseDate: "2014-11-05",
        overview: "Interstellar chronicles the adventures of a group of explorers who " +
            "make use of a newly discovered wormhole to surpass the limitations on human " +
            "space travel and conquer the vast distances involved in an interstellar voyage.")
}
