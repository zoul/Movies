import Foundation

public enum ServerResponse<T> {
    case success(T)
    case error(String)
}

public class MovieListRequest {

    public let apiKey: String
    public let pageNumber: Int

    public init(apiKey: String, pageNumber: Int = 1) {
        self.apiKey = apiKey
        self.pageNumber = pageNumber
    }

    public var httpRequest: URLRequest? {
        guard
            let encodedApiKey = apiKey.urlEncodedString,
            let url = URL(string: "https://api.themoviedb.org/3/movie/popular?api_key=\(encodedApiKey)&page=\(pageNumber)")
            else { return nil }
        var request = URLRequest(url: url)
        request.cachePolicy = .returnCacheDataElseLoad
        request.httpMethod = "GET"
        return request
    }

    public func send(completion: @escaping (ServerResponse<MovieListResponse>) -> Void) {
        guard let request = httpRequest else {
            completion(.error("Failed to build HTTP request."))
            return
        }
        let task = URLSession.shared.dataTask(with: request) { data, response, error in

            // Basic connectivity issues: no network etc.
            if let _ = error {
                completion(.error("No network connection."))
                return
            }

            // Weird case where there’s no response and no error
            guard let response = response as? HTTPURLResponse else {
                completion(.error("Received no error, but no response either."))
                return
            }

            // Plain HTTP error
            if response.statusCode < 200 || response.statusCode > 299 {
                completion(.error("HTTP error #\(response.statusCode)"))
                return
            }

            // Weird case where we get HTTP success, but no response
            guard let data = data else {
                completion(.error("HTTP request succeeded, but no data was returned."))
                return
            }

            // Response parse error
            guard let parsedResponse = MovieListResponse(jsonData: data) else {
                completion(.error("Error parsing server response."))
                return
            }

            // Success
            completion(.success(parsedResponse))
        }

        task.resume()
    }
}
