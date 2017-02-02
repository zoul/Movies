import Foundation

public protocol JSONDecodable {

    init?(jsonObject: AnyObject)
}

extension JSONDecodable {

    init?(jsonData: Data) {
        if let object = try? JSONSerialization.jsonObject(with: jsonData, options: []) {
            self.init(jsonObject: object as AnyObject)
        } else {
            return nil
        }
    }

    init?(jsonString: String) {
        if let data = jsonString.data(using: String.Encoding.utf8) {
            self.init(jsonData: data)
        } else {
            return nil
        }
    }
}
