import SwiftUI

struct SeeAllView: View {
    let movie: Movie
    let genreText: String

    var body: some View {
        VStack(spacing: 16) {
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
                            .frame(width: 150, height: 200)
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

            
                Text("\(movie.title)")
                    .font(.headline)
                    .foregroundColor(.white)
            
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
        SeeAllView(
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
