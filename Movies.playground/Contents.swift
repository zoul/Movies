import UIKit
import MovieKit
import PlaygroundSupport

PlaygroundPage.current.needsIndefiniteExecution = true

let request = MovieListRequest(apiKey: "XXX")
request.send { response in
    print(response)
    PlaygroundPage.current.finishExecution()
}
