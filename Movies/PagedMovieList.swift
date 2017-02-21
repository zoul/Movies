import Foundation
import MovieKit

class PagedMovieList {

    private let queue = DispatchQueue(label: "PagedMovieList")
    private let webService = WebService(apiKey: "XXX")

    public private(set) var lastLoadedPageNumber = 0

    func loadOneMorePage(completion: @escaping ([Movie]?) -> Void) {
        queue.async {
            let nextPageNumber = self.lastLoadedPageNumber+1
            print("Loading page #\(nextPageNumber)")
            let response = self.webService.loadSynchronously(resource: Movie.popular(pageNumber: nextPageNumber))
            switch response {
                case .success(let response):
                    self.lastLoadedPageNumber = nextPageNumber
                    completion(response.results)
                case .error(let msg):
                    print("Page #\(nextPageNumber) failed to load: \(msg)")
                    completion(nil)
            }
        }
    }
}
