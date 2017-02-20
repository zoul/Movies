import Foundation

// https://developers.themoviedb.org/3/movies/get-popular-movies
//
// Note that while the fields are mostly marked as optional in the
// spec, we treat most of them as required. If our required fields
// are missing in the encoded response, we reject the whole response.
public struct MovieListPage {

    public let pageNumber: Int
    public let totalResults: Int
    public let totalPages: Int
    public let results: [Movie]
}

extension MovieListPage: JSONDecodable {

    public init?(jsonObject: Any) {

        guard let dict = jsonObject as? NSDictionary,
            let pageNumber = dict["page"] as? Int,
            let totalResults = dict["total_results"] as? Int,
            let totalPages = dict["total_pages"] as? Int,
            let serializedResults = dict["results"] as? NSArray
            else { return nil }

        self.pageNumber = pageNumber
        self.totalResults = totalResults
        self.totalPages = totalPages
        self.results = serializedResults.flatMap(Movie.init)
    }
}
