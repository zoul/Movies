import XCTest
@testable import MovieKit

class MovieListRequestTests: XCTestCase {

    func testRequestBuilding() {
        let request = MovieListRequest(apiKey: "foo/bar").httpRequest
        XCTAssertEqual(request?.httpMethod, "GET")
        XCTAssertEqual(request?.url?.absoluteString, "https://api.themoviedb.org/3/movie/popular?api_key=foo%2Fbar&page=1")
    }
}
