import Foundation
import UIKit

extension UIImage {

    /// Return a cached image from given URL
    ///
    /// Returns `nil` if the URL can’t be loaded and there is no cached data.
    /// `URLCache.shared` is used for caching. Callback is guaranteed to run on
    /// the main queue.
    class func cachedImage(withURL url: URL, completion: @escaping (UIImage?) -> Void) {
        DispatchQueue.global().async {
            let request = URLRequest(url: url, cachePolicy: .returnCacheDataElseLoad, timeoutInterval: 10)
            let task = URLSession.shared.dataTask(with: request) { data, response, error in
                if let data = data, let image = UIImage(data: data) {
                    DispatchQueue.main.async {
                        completion(image)
                    }
                } else {
                    DispatchQueue.main.async {
                        completion(nil)
                    }
                }
            }
            task.resume()
        }
    }
}
