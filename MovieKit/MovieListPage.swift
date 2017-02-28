import Foundation

// https://developers.themoviedb.org/3/movies/get-popular-movies
//
// Note that while the fields are mostly marked as optional in the
// spec, we treat most of them as required. If our required fields
// are missing in the encoded response, we reject the whole response.
public struct MovieListPage {

    public let pageNumber: Int
    public let totalResults: Int
    public let totalPages: Int
    public let results: [Movie]
}

extension MovieListPage: JSONDecodable {

    public init?(jsonObject: Any) {

        guard let dict = jsonObject as? NSDictionary,
            let pageNumber = dict["page"] as? Int,
            let totalResults = dict["total_results"] as? Int,
            let totalPages = dict["total_pages"] as? Int,
            let serializedResults = dict["results"] as? NSArray
            else { return nil }

        self.pageNumber = pageNumber
        self.totalResults = totalResults
        self.totalPages = totalPages
        self.results = serializedResults.flatMap(Movie.init)
    }
}

extension MovieListPage {

    public static let template = MovieListPage(pageNumber: 1, totalResults: 10, totalPages: 1, results: [
        // swiftlint:disable line_length
        Movie(id: 297761, title: "Suicide Squad", voteAverage: 5.91, backdropPath: "/ndlQ2Cuc3cjTL7lTynw6I4boP4S.jpg", releaseDate: "2016-08-03", overview: "From DC Comics comes the Suicide Squad, an antihero team of incarcerated supervillains who act as deniable assets for the United States government, undertaking high-risk black ops missions in exchange for commuted prison sentences."),
        Movie(id: 324668, title: "Jason Bourne", voteAverage: 5.25, backdropPath: "/AoT2YrJUJlg5vKE3iMOLvHlTd3m.jpg", releaseDate: "2016-07-27", overview: "The most dangerous former operative of the CIA is drawn out of hiding to uncover hidden truths about his past."),
        Movie(id: 291805, title: "Now You See Me 2", voteAverage: 6.64, backdropPath: "/zrAO2OOa6s6dQMQ7zsUbDyIBrAP.jpg", releaseDate: "2016-06-02", overview: "One year after outwitting the FBI and winning the public’s adulation with their mind-bending spectacles, the Four Horsemen resurface only to find themselves face to face with a new enemy who enlists them to pull off their most dangerous heist yet."),
        Movie(id: 241251, title: "The Boy Next Door", voteAverage: 4.13, backdropPath: "/vj4IhmH4HCMZYYjTMiYBybTWR5o.jpg", releaseDate: "2015-01-23", overview: "A recently cheated on married woman falls for a younger man who has moved in next door, but their torrid affair soon takes a dangerous turn."),
        Movie(id: 278927, title: "The Jungle Book", voteAverage: 6.42, backdropPath: "/eIOTsGg9FCVrBc4r2nXaV61JF4F.jpg", releaseDate: "2016-04-07", overview: "An orphan boy is raised in the Jungle with the help of a pack of wolves, a bear and a black panther."),
        Movie(id: 278924, title: "Mechanic:Resurrection", voteAverage: 4.59, backdropPath: "/3oRHlbxMLBXHfMqUsx1emwqiuQ3.jpg", releaseDate: "2016-08-25", overview: "Arthur Bishop thought he had put his murderous past behind him when his most formidable foe kidnaps the love of his life. Now he is forced to travel the globe to complete three impossible assassinations, and do what he does best, make them look like accidents."),
        Movie(id: 209112, title: "Batman v Superman:Dawn of Justice", voteAverage: 5.52, backdropPath: "/vsjBeMPZtyB7yNsYY56XYxifaQZ.jpg", releaseDate: "2016-03-23", overview: "Fearing the actions of a god-like Super Hero left unchecked, Gotham City’s own formidable, forceful vigilante takes on Metropolis’s most revered, modern-day savior, while the world wrestles with what sort of hero it really needs. And with Batman and Superman at war with one another, a new threat quickly arises, putting mankind in greater danger than it’s ever known before."),
        Movie(id: 76341, title: "Mad Max:Fury Road", voteAverage: 7.26, backdropPath: "/tbhdm8UJAb4ViCTsulYFL3lxMCd.jpg", releaseDate: "2015-05-13", overview: "An apocalyptic story set in the furthest reaches of our planet, in a stark desert landscape where humanity is broken, and most everyone is crazed fighting for the necessities of life. Within this world exist two rebels on the run who just might be able to restore order. There's Max, a man of action and a man of few words, who seeks peace of mind following the loss of his wife and child in the aftermath of the chaos. And Furiosa, a woman of action and a woman who believes her path to survival may be achieved if she can make it across the desert back to her childhood homeland."),
        Movie(id: 271110, title: "Captain America:Civil War", voteAverage: 6.93, backdropPath: "/m5O3SZvQ6EgD5XXXLPIP1wLppeW.jpg", releaseDate: "2016-04-27", overview: "Following the events of Age of Ultron, the collective governments of the world pass an act designed to regulate all superhuman activity. This polarizes opinion amongst the Avengers, causing two factions to side with Iron Man or Captain America, which causes an epic battle between former allies."),
        Movie(id: 135397, title: "Jurassic World", voteAverage: 6.59, backdropPath: "/dkMD5qlogeRMiEixC4YNPUvax2T.jpg", releaseDate: "2015-06-09", overview: "Twenty-two years after the events of Jurassic Park, Isla Nublar now features a fully functioning dinosaur theme park, Jurassic World, as originally envisioned by John Hammond."),
        Movie(id: 131631, title: "The Hunger Games:Mockingjay - Part 1", voteAverage: 6.69, backdropPath: "/83nHcz2KcnEpPXY50Ky2VldewJJ.jpg", releaseDate: "2014-11-18", overview: "Katniss Everdeen reluctantly becomes the symbol of a mass rebellion against the autocratic Capitol."),
        Movie(id: 168259, title: "Furious 7", voteAverage: 7.39, backdropPath: "/ypyeMfKydpyuuTMdp36rMlkGDUL.jpg", releaseDate: "2015-04-01", overview: "Deckard Shaw seeks revenge against Dominic Toretto and his family for his comatose brother."),
        Movie(id: 87101, title: "Terminator Genisys", voteAverage: 5.91, backdropPath: "/bIlYH4l2AyYvEysmS2AOfjO7Dn8.jpg", releaseDate: "2015-06-23", overview: "The year is 2029. John Connor, leader of the resistance continues the war against the machines. At the Los Angeles offensive, John's fears of the unknown future begin to emerge when TECOM spies reveal a new plot by SkyNet that will attack him from both fronts; past and future, and will ultimately change warfare forever."),
        Movie(id: 211672, title: "Minions", voteAverage: 6.55, backdropPath: "/uX7LXnsC7bZJZjn048UCOwkPXWJ.jpg", releaseDate: "2015-06-17", overview: "Minions Stuart, Kevin and Bob are recruited by Scarlet Overkill, a super-villain who, alongside her inventor husband Herb, hatches a plot to take over the world."),
        Movie(id: 157336, title: "Interstellar", voteAverage: 8.12, backdropPath: "/xu9zaAevzQ5nnrsXN6JcahLnG4i.jpg", releaseDate: "2014-11-05", overview: "Interstellar chronicles the adventures of a group of explorers who make use of a newly discovered wormhole to surpass the limitations on human space travel and conquer the vast distances involved in an interstellar voyage."),
        Movie(id: 278154, title: "Ice Age:Collision Course", voteAverage: 5.15, backdropPath: "/o29BFNqgXOUT1yHNYusnITsH7P9.jpg", releaseDate: "2016-06-23", overview: "Set after the events of Continental Drift, Scrat's epic pursuit of his elusive acorn catapults him outside of Earth, where he accidentally sets off a series of cosmic events that transform and threaten the planet. To save themselves from peril, Manny, Sid, Diego, and the rest of the herd leave their home and embark on a quest full of thrills and spills, highs and lows, laughter and adventure while traveling to exotic new lands and encountering a host of colorful new characters."),
        Movie(id: 293660, title: "Deadpool", voteAverage: 7.16, backdropPath: "/nbIrDhOtUpdD9HKDBRy02a8VhpV.jpg", releaseDate: "2016-02-09", overview: "Based upon Marvel Comics’ most unconventional anti-hero, DEADPOOL tells the origin story of former Special Forces operative turned mercenary Wade Wilson, who after being subjected to a rogue experiment that leaves him with accelerated healing powers, adopts the alter ego Deadpool. Armed with his new abilities and a dark, twisted sense of humor, Deadpool hunts down the man who nearly destroyed his life."),
        Movie(id: 290250, title: "The Nice Guys", voteAverage: 6.84, backdropPath: "/8GwMVfq8Hsq1EFbw2MYJgSCAckb.jpg", releaseDate: "2016-05-15", overview: "A private eye investigates the apparent suicide of a fading porn star in 1970s Los Angeles and uncovers a conspiracy."),
        Movie(id: 325133, title: "Neighbors 2:Sorority Rising", voteAverage: 5.36, backdropPath: "/8HuO1RMDI3prfWDkF7t1y8EhLVO.jpg", releaseDate: "2016-05-05", overview: "A sorority moves in next door to the home of Mac and Kelly Radner who have a young child. The Radner's enlist their former nemeses from the fraternity to help battle the raucous sisters."),
        Movie(id: 244786, title: "Whiplash", voteAverage: 8.29, backdropPath: "/6bbZ6XyvgfjhQwbplnUh1LSj1ky.jpg", releaseDate: "2014-10-10", overview: "Under the direction of a ruthless instructor, a talented young drummer begins to pursue perfection at any cost, even his humanity.")
        // swiftlint:enable line_length
    ])
}
