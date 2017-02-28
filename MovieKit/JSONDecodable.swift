import Foundation

// TODO: Report parsing errors in detail?
public protocol JSONDecodable {

    init?(jsonObject: Any)
}

extension JSONDecodable {

    public init?(jsonData: Data) {
        if let object = try? JSONSerialization.jsonObject(with: jsonData, options: []) {
            self.init(jsonObject: object as AnyObject)
        } else {
            return nil
        }
    }

    public init?(jsonString: String) {
        if let data = jsonString.data(using: String.Encoding.utf8) {
            self.init(jsonData: data)
        } else {
            return nil
        }
    }
}
