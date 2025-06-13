import Foundation

struct Genre: Decodable, Identifiable {
    let id: Int
    let name: String
}

struct Movie: Identifiable, Decodable {
    let id: Int
    let title: String
    let release_date: String
    let overview: String
    let voteAverage: Double
    let posterPath: String?
    let genreIDs: [Int]
    let originalLanguage: String
    let popularity: Double
    let voteCount: Int

    var releaseYear: String {
        String(release_date.prefix(4))
    }
    

    var posterURL: URL? {
        guard let path = posterPath else { return nil }
        return URL(string: "https://image.tmdb.org/t/p/w500\(path)")
    }

    enum CodingKeys: String, CodingKey {
        case id, title, overview, release_date, popularity
        case voteCount = "vote_count"
        case voteAverage = "vote_average"
        case posterPath = "poster_path"
        case genreIDs = "genre_ids"
        case originalLanguage = "original_language"
    }
}
