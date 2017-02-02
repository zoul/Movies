import Foundation

// https://developers.themoviedb.org/3/movies/get-popular-movies
//
// Note that while the fields are mostly marked as optional in the
// spec, we treat most of them as required. If our required fields
// are missing in the encoded response, we reject the whole response.
public struct MovieListResponse {

    public let page: Int
    public let totalResults: Int
    public let totalPages: Int
    public let results: [Movie]
}

extension MovieListResponse: JSONDecodable {

    public init?(jsonObject: AnyObject) {
        guard let dict = jsonObject as? NSDictionary,
            let page = dict["page"] as? Int,
            let totalResults = dict["total_results"] as? Int,
            let totalPages = dict["total_pages"] as? Int,
            let serializedResults = dict["results"] as? NSArray
            else { return nil }
        let results = serializedResults.flatMap { Movie.init(jsonObject: $0 as AnyObject) }
        self.init(page: page, totalResults: totalResults, totalPages: totalPages, results: results)
    }
}
