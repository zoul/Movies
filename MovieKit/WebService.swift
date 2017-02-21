import Foundation

public enum Response<T> {
    case success(T)
    case error(String)
}

// TODO: Improve error reporting
// TODO: Retry support
// TODO: Improve caching
// TODO: Internal request queue?
public final class WebService {

    public let apiKey: String

    public init(apiKey: String) {
        self.apiKey = apiKey
    }

    public func load<T>(resource: Resource<T>, completion: @escaping (Response<T>) -> Void) {

        let request = urlRequestForResource(resource)
        URLSession.shared.dataTask(with: request) { data, response, error in

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
                let msg = HTTPURLResponse.localizedString(forStatusCode: response.statusCode)
                completion(.error("HTTP error #\(response.statusCode): \(msg)."))
                return
            }

            // Weird case where we get HTTP success, but no response
            guard let data = data else {
                completion(.error("HTTP request succeeded, but no data was returned."))
                return
            }

            // Response parse error
            guard let parsedResponse = resource.parse(data) else {
                completion(.error("Error parsing server response."))
                return
            }

            // Success
            completion(.success(parsedResponse))

        }.resume()
    }

    public func loadSynchronously<T>(resource: Resource<T>) -> Response<T> {
        let semaphore = DispatchSemaphore(value: 0)
        var response: Response<T>? = nil
        load(resource: resource) {
            response = $0
            semaphore.signal()
        }
        semaphore.wait()
        return response!
    }

    func urlRequestForResource<T>(_ resource: Resource<T>) -> URLRequest {
        let params = mergeDictionaries(["api_key": apiKey], resource.urlParams)
        let url = URL(string: resource.url.absoluteString + "?" + encodeUrlParams(params: params))!
        return URLRequest(url: url)
    }
}

extension WebService {

    fileprivate func encodeUrlParams(params: [String:String]) -> String {
        var items: [String] = []
        for (key, val) in params {
            if let encKey = encodeUrlString(key), let encVal = encodeUrlString(val) {
                items.append(encKey + "=" + encVal)
            }
        }
        return items.joined(separator: "&")
    }

    fileprivate func encodeUrlString(_ string: String) -> String? {
        let allowedSet =  CharacterSet(charactersIn:
            "0123456789abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ-._~")
        return string.addingPercentEncoding(withAllowedCharacters: allowedSet)
    }

    fileprivate func mergeDictionaries(_ left: [String:String], _ right: [String:String]) -> [String:String] {
        var map: [String:String] = [:]
        for (k, v) in left {
            map[k] = v
        }
        for (k, v) in right {
            map[k] = v
        }
        return map
    }
}
