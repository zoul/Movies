// swiftlint:disable line_length

import UIKit
import MovieKit
import MoviesUI
import PlaygroundSupport

let movie = Movie.template
let movieVC = MovieDetailController(movie: movie)

PlaygroundPage.current.liveView = movieVC
