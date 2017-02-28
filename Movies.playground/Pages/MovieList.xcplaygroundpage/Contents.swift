import UIKit
import MovieKit
import MoviesUI
import PlaygroundSupport

let listVC = MovieListController()
listVC.loadOneMorePage = { callback in
    callback(MovieListPage.template.results)
}

PlaygroundPage.current.liveView = listVC
