import Foundation

public struct Resource<T> {

    public let url: URL
    public let parse: (Data) -> T?
    public let urlParams: [String:String]
}

extension Resource where T : JSONDecodable {

    init(url: URL, urlParams: [String:String] = [:]) {
        self.url = url
        self.urlParams = urlParams
        self.parse = { data in
            let json = try? JSONSerialization.jsonObject(with: data, options: [])
            return json.flatMap(T.init)
        }
    }
}
