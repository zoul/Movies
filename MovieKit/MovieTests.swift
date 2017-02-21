// swiftlint:disable line_length
import XCTest
@testable import MovieKit

class MovieTests: XCTestCase {

    func testDeserialization() {
        let serialized = "{\"poster_path\":\"/e1mjopzAS2KNsvpbpahQ1a6SkSn.jpg\",\"adult\":false,\"overview\":\"From DC Comics comes the Suicide Squad, an antihero team of incarcerated supervillains who act as deniable assets for the United States government, undertaking high-risk black ops missions in exchange for commuted prison sentences.\",\"release_date\":\"2016-08-03\",\"genre_ids\":[14,28,80],\"id\":297761,\"original_title\":\"Suicide Squad\",\"original_language\":\"en\",\"title\":\"Suicide Squad\",\"backdrop_path\":\"/ndlQ2Cuc3cjTL7lTynw6I4boP4S.jpg\",\"popularity\":48.261451,\"vote_count\":1466,\"video\":false,\"vote_average\":5.91}"
        let movie = Movie(jsonString: serialized)
        XCTAssertNotNil(movie)
        XCTAssertEqual(movie?.id, 297761)
        XCTAssertEqual(movie?.title, "Suicide Squad")
        XCTAssertEqual(movie?.voteAverage, 5.91)
        XCTAssertEqual(movie?.backdropPath, "/ndlQ2Cuc3cjTL7lTynw6I4boP4S.jpg")
        XCTAssertEqual(movie?.overview, "From DC Comics comes the Suicide Squad, an antihero team of incarcerated supervillains who act as deniable assets for the United States government, undertaking high-risk black ops missions in exchange for commuted prison sentences.")
        XCTAssertEqual(movie?.releaseDate, "2016-08-03")
    }
}
