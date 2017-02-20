import UIKit
import MovieKit
import PlaygroundSupport

PlaygroundPage.current.needsIndefiniteExecution = true

let service = WebService(apiKey: "XXX")
service.load(resource: Movie.popular()) { resource in
    print(resource)
    PlaygroundPage.current.finishExecution()
}
