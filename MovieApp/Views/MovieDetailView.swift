import SwiftUI

struct MovieDetailView: View {
    let movie: Movie
    @ObservedObject var viewModel = MovieViewModel()
    var genreText: String {
        viewModel.genreNames(for: movie.genreIDs)
    }
    
    
    
    func formatDate(from dateString: String) -> String {
        let inputFormatter = DateFormatter()
        inputFormatter.dateFormat = "yyyy-MM-dd"
        
        let outputFormatter = DateFormatter()
        outputFormatter.dateFormat = "dd-MM-yyyy"
        
        if let date = inputFormatter.date(from: dateString) {
            return outputFormatter.string(from: date)
        } else {
            return dateString
        }
    }
    
    
    func languageDisplayName(from originalLanguage: String) -> String {
        switch originalLanguage {
        case "en": return "English"
        case "es": return "Spanish"
        case "fr": return "French"
        case "ja": return "Japanese"
        case "ko": return "Korean"
        case "zh": return "Chinese"
        case "hi": return "Hindi"
        case "id": return "Indonesia"
        default: return "Unknown"
        }
    }
    
    var body: some View {
        ZStack{
            Color.black.ignoresSafeArea()
            ScrollView(showsIndicators: false) {
                VStack(alignment: .leading, spacing: 16) {
                    HStack(alignment: .top, spacing: 16) {
                        if let url = movie.posterURL {
                            AsyncImage(url: url) { phase in
                                switch phase {
                                case .empty:
                                    ProgressView()
                                        .frame(width: 120, height: 180)
                                        .cornerRadius(12)
                                case .success(let image):
                                    image
                                        .resizable()
                                        .scaledToFill()
                                        .frame(width: 120, height: 180)
                                        .clipped()
                                        .cornerRadius(12)
                                case .failure:
                                    Image(systemName: "photo")
                                        .frame(width: 120, height: 180)
                                        .cornerRadius(12)
                                @unknown default:
                                    EmptyView()
                                }
                            }
                        }
                        
                        VStack(alignment: .leading, spacing: 6) {
                            Text("\(movie.title)")
                                .font(.custom("Poppins-Bold", size: 18))
                                .foregroundColor(.white)
                            HStack(spacing: 3) {
                                ForEach(getStars(from: movie.voteAverage), id: \.self) { starName in
                                    Image(starName)
                                        .resizable()
                                        .frame(width: 12, height: 12)
                                }
                            }
                            .padding(.bottom, 30)
                            
                            Spacer()
                            Text("\(formatDate(from: movie.release_date))")
                                .foregroundColor(.white)
                                .font(.custom("Poppins-SemiBold", size: 12))
                                .padding(.bottom, -5)
                            Text("Ekalma T. A. Sembiring")
                                .foregroundColor(.white)
                                .font(.custom("Poppins-Medium", size: 10))
                                .padding(.bottom, 2)
                            Text(genreText)
                                .foregroundColor(.gray)
                                .font(.custom("Poppins-Medium", size: 12))
                                .padding(.bottom, 14)
                        }
                        .padding()
                    }
                    .padding()
                    
                    
                    HStack(spacing: 42) {
                        Spacer()
                        VStack(spacing: 12) {
                            Text("Language")
                                .foregroundColor(.gray)
                                .multilineTextAlignment(.center)
                                .font(.caption)
                            Text(languageDisplayName(from: movie.originalLanguage))
                                .font(.custom("Poppins-SemiBold", size: 18))
                                .foregroundColor(.white)
                                .multilineTextAlignment(.center)
                        }
                        VStack(spacing: 12) {
                            Text("Comments")
                                .foregroundColor(.gray)
                                .font(.caption)
                                .multilineTextAlignment(.center)
                            Text("\(movie.voteCount)")
                                .font(.custom("Poppins-SemiBold", size: 18))
                                .foregroundColor(.white)
                                .multilineTextAlignment(.center)
                        }
                        VStack(spacing: 12) {
                            Text("Popularity")
                                .foregroundColor(.gray)
                                .font(.caption)
                                .multilineTextAlignment(.center)
                            Text(String(format: "%.0f", movie.popularity))
                                .font(.custom("Poppins-SemiBold", size: 18))
                                .foregroundColor(.white)
                                .multilineTextAlignment(.center)
                        }
                        Spacer()
                    }
                    .frame(maxWidth: .infinity, alignment: .center)
                    
                    VStack(alignment: .leading, spacing: 12) {
                        Text("Overview")
                            .font(.custom("Poppins-SemiBoldItalic", size: 26))
                            .bold()
                            .foregroundColor(.primaryRed_)
                        
                        Text(movie.overview)
                            .font(.body)
                            .foregroundColor(.white)
                    }
                    .padding()
                    
                    VStack(alignment: .leading, spacing: 10) {
                        Text("See All")
                            .font(.custom("Poppins-SemiBoldItalic", size: 26))
                            .bold()
                            .foregroundColor(.primaryRed_)
                        ScrollView(.horizontal, showsIndicators: false) {
                            HStack(spacing: 16) {
                                ForEach(viewModel.movies) { movie in
                                    NavigationLink(destination: MovieDetailView(movie: movie, viewModel: viewModel)) {
                                        SeeAllView(movie: movie, genreText: viewModel.genreNames(for: movie.genreIDs))
                                    }

                                }
                            }
                        }
                    }
                    .padding(.bottom, 12)
                    .padding()
                }
                .padding(.top, 90)
            }
            .background(Color.black)
            .ignoresSafeArea()
            .onAppear {
                let appearance = UINavigationBarAppearance()
                appearance.configureWithTransparentBackground()
                appearance.backgroundColor = .clear
                UINavigationBar.appearance().standardAppearance = appearance
                UINavigationBar.appearance().scrollEdgeAppearance = appearance
                viewModel.fetchMovies()
                viewModel.fetchGenres()
            }
        }
    }
}

// MARK: - Preview
#Preview {
    ZStack {
        Color.black.ignoresSafeArea()
        MovieDetailView(
            movie: Movie(
                id: 1,
                title: "Inception",
                release_date: "2018",
                overview: "A thief who steals corporate secrets through the use of dream-sharing technology...",
                voteAverage: 9.0,
                posterPath: "/qvktm0BHcnmDpul4Hz01GIazWPr.jpg",
                genreIDs: [28, 878, 12],
                originalLanguage: "en",
                popularity: 12321,
                voteCount: 123
            )
        )
        .padding()
    }
}

