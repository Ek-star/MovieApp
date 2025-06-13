import SwiftUI

func getStars(from voteAverage: Double) -> [String] {
    let rating = min(max(voteAverage / 2.0, 0), 5) // Convert 0–10 -> 0–5
    let fullStars = Int(rating)
    let hasHalfStar = rating - Double(fullStars) >= 0.25 && rating - Double(fullStars) < 0.75
    let maxStars = 5

    var stars: [String] = []

    for _ in 0..<fullStars {
        stars.append("full_star")
    }

    if hasHalfStar {
        stars.append("half_star")
    }

    for _ in 0..<(maxStars - stars.count) {
        stars.append("empty_star")
    }

    return stars
}


struct MovieCard: View {
    let movie: Movie
    let genreText: String

    var body: some View {
        HStack(spacing: 16) {
            if let url = movie.posterURL {
                AsyncImage(url: url) { phase in
                    switch phase {
                    case .empty:
                        ProgressView()
                            .frame(width: 100, height: 150)
                    case .success(let image):
                        image
                            .resizable()
                            .scaledToFill()
                            .frame(width: 100, height: 150)
                            .clipped()
                            .cornerRadius(8)
                    case .failure:
                        Image(systemName: "photo")
                            .resizable()
                            .frame(width: 100, height: 150)
                    @unknown default:
                        EmptyView()
                    }
                }
            }

            VStack(alignment: .leading, spacing: 6) {
                Text("\(movie.title)")
                    .font(.headline)
                    .foregroundColor(.white)

                HStack(spacing: 5) {
                    ForEach(getStars(from: movie.voteAverage), id: \.self) { starName in
                        Image(starName)
                            .resizable()
                            .frame(width: 12, height: 12)
                    }
                    Text(String(format: "%.1f/10 Rating", movie.voteAverage))
                        .foregroundColor(.primaryRed)
                        .shadow(radius: 2)
                        .font(.custom("Poppins-MediumItalic", size: 12))
                        .padding(.leading, 10)
                }

                Text(genreText)
                    .font(.custom("Poppins-Regular", size: 11))
                    .foregroundColor(.white)
                    .lineLimit(1)
                    .padding(.top, 16)
                    .padding(.bottom, -5)

                Text(movie.overview)
                    .font(.custom("Poppins-Medium", size: 12))
                    .foregroundColor(Color(red: 121/225, green: 121/225, blue: 121/225))
                    .lineLimit(3)
                    .multilineTextAlignment(.leading)
                    .frame(maxWidth: .infinity, alignment: .leading)
            }
        }
        .padding()
        .background(Color.black.opacity(0.7))
        .cornerRadius(12)
        .shadow(color: .black.opacity(0.3), radius: 5, x: 0, y: 3)
    }
}




// MARK: - Preview
#Preview {
    ZStack {
        Color.black.ignoresSafeArea()
        MovieCard(
            movie: Movie(
                id: 1,
                title: "Inception",
                release_date: "2018",
                overview: "A thief who steals corporate secrets through the use of dream-sharing technology...",
                voteAverage: 9.0,
                posterPath: "/qvktm0BHcnmDpul4Hz01GIazWPr.jpg",
                genreIDs: [28, 878, 12],
                originalLanguage: "en",
                popularity: 323453,
                voteCount: 456
            ),
            genreText: "Action, Sci-Fi, Adventure"
        )
        .padding()
    }
}
