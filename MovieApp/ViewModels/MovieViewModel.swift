import Foundation
import Combine

class MovieViewModel: ObservableObject {
    @Published var movies: [Movie] = []
    @Published var isLoading: Bool = false
    @Published var errorMessage: String? = nil
    @Published var genres: [Genre] = []

    func fetchMovies() {
        isLoading = true
        errorMessage = nil

        let apiKey = "72b1b7775c97a3fc05da67b9674cf90c"
        guard let url = URL(string: "https://api.themoviedb.org/3/movie/popular?api_key=\(apiKey)&language=en-US&page=1") else {
            self.errorMessage = "Invalid URL"
            self.isLoading = false
            return
        }

        URLSession.shared.dataTask(with: url) { data, response, error in
            DispatchQueue.main.async {
                self.isLoading = false

                if let error = error {
                    self.errorMessage = error.localizedDescription
                    return
                }

                guard let data = data else {
                    self.errorMessage = "No data received"
                    return
                }

                do {
                    let response = try JSONDecoder().decode(MovieResponse.self, from: data)
                    self.movies = response.results
                } catch {
                    self.errorMessage = "Failed to decode data: \(error.localizedDescription)"
                }
            }
        }.resume()
    }

    func fetchGenres() {
        let apiKey = "72b1b7775c97a3fc05da67b9674cf90c"
        guard let url = URL(string: "https://api.themoviedb.org/3/genre/movie/list?api_key=\(apiKey)&language=en-US") else {
            return
        }

        URLSession.shared.dataTask(with: url) { data, _, error in
            DispatchQueue.main.async {
                if let error = error {
                    print("Failed to fetch genres: \(error.localizedDescription)")
                    return
                }

                guard let data = data else {
                    print("No data for genres")
                    return
                }

                do {
                    let response = try JSONDecoder().decode(GenreResponse.self, from: data)
                    self.genres = response.genres
                } catch {
                    print("Failed to decode genres: \(error.localizedDescription)")
                }
            }
        }.resume()
    }

    func genreNames(for ids: [Int]) -> String {
        let names = genres.filter { ids.contains($0.id) }.map { $0.name }
        return names.joined(separator: ", ")
    }
}

struct MovieResponse: Decodable {
    let results: [Movie]
}

struct GenreResponse: Decodable {
    let genres: [Genre]
}
