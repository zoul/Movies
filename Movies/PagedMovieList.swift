import Foundation
import MovieKit

class PagedMovieList {

    private let apiKey = "XXX"
    private let queue = DispatchQueue(label: "PagedMovieList")

    public private(set) var movies: [Movie] = []
    public private(set) var lastLoadedPageNumber = 0

    func loadOneMorePage(completion: @escaping (Int) -> Void) {
        queue.async {
            let nextPageNumber = self.lastLoadedPageNumber+1
            let semaphore = DispatchSemaphore(value: 0)
            let request = MovieListRequest(apiKey: self.apiKey, pageNumber: nextPageNumber)
            print("Will load page #\(nextPageNumber)")
            request.send { response in
                switch response {
                    case .success(let response):
                        let newItemCount = response.results.count
                        self.movies.append(contentsOf: response.results)
                        self.lastLoadedPageNumber = nextPageNumber
                        print("Page #\(nextPageNumber) loaded successfully, \(newItemCount) items, \(self.movies.count) total.")
                        completion(newItemCount)
                        semaphore.signal()
                    case .error(let msg):
                        print("Page #\(nextPageNumber) failed to load: \(msg)")
                        completion(0)
                        semaphore.signal()
                }
            }
            semaphore.wait()
        }
    }
}
