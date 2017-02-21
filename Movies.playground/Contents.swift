import UIKit
import MovieKit

let service = WebService(apiKey: "XXX")
let response = service.loadSynchronously(resource: Movie.popular())
print(response)
