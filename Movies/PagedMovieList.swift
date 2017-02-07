import Foundation
import MovieKit

class PagedMovieList {

    private let apiKey = "XXX"
    private let queue = DispatchQueue(label: "PagedMovieList")

    public private(set) var lastLoadedPageNumber = 0

    func loadOneMorePage(completion: @escaping ([Movie]?) -> Void) {
        queue.async {
            let nextPageNumber = self.lastLoadedPageNumber+1
            let semaphore = DispatchSemaphore(value: 0)
            let request = MovieListRequest(apiKey: self.apiKey, pageNumber: nextPageNumber)
            print("Loading page #\(nextPageNumber)")
            request.send { response in
                switch response {
                    case .success(let response):
                        self.lastLoadedPageNumber = nextPageNumber
                        completion(response.results)
                        semaphore.signal()
                    case .error(let msg):
                        print("Page #\(nextPageNumber) failed to load: \(msg)")
                        completion(nil)
                        semaphore.signal()
                }
            }
            semaphore.wait()
        }
    }
}
