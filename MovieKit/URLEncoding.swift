import Foundation

extension String {

    var urlEncodedString: String? {
        let allowedSet =  CharacterSet(charactersIn: "0123456789abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ-._~")
        return self.addingPercentEncoding(withAllowedCharacters: allowedSet)
    }
}
