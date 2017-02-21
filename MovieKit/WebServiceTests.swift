import XCTest
@testable import MovieKit

class WebServiceTests: XCTestCase {

    func testRequestBuilding() {
        let resource = Resource<Void>(
            url: URL(string: "http://www.example.com/")!,
            parse: { _ in return }, urlParams: ["tag": "foo/bar"])
        let webService = WebService(apiKey: "foo:bar")
        let request = webService.urlRequestForResource(resource)
        XCTAssertEqual(request.url?.absoluteString, "http://www.example.com/?api_key=foo%3Abar&tag=foo%2Fbar")
        XCTAssertEqual(request.httpMethod, "GET")
    }
}
