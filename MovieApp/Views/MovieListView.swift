//
//  MovieListView.swift
//  MovieApp
//
//  Created by EKALMA TOTO ALLOY SEMBIRING on 11/06/25.
//

import SwiftUI

struct MovieListView: View {
    @StateObject private var viewModel = MovieViewModel()

    var body: some View {
        NavigationStack {
            ZStack{
                Image("background")
                    .resizable()
                    .scaledToFill()
                    .ignoresSafeArea()
                    .overlay(Color.black.opacity(0.5))
                
                
                VStack(spacing: 12) {
                    Spacer()
                    Spacer()
                    HStack(spacing: 0) {
                        Text("Movie")
                            .font(.custom("Poppins-ExtraBoldItalic", size: 45))
                            .foregroundColor(.white)
                            .shadow(radius: 2)
                        Text("s")
                            .font(.custom("Poppins-ExtraBoldItalic", size: 45))
                            .foregroundColor(.primaryRed)
                            .shadow(radius: 2)
                        Spacer()
                    }
                    .padding(.leading, 20)
                    .padding(.top,10)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    Spacer()
                ScrollView(showsIndicators: false) {
                    LazyVStack(spacing: 20) {
                        ForEach(viewModel.movies) { movie in
                            NavigationLink(destination: MovieDetailView(movie: movie, viewModel: viewModel)) {
                                MovieCard(
                                    movie: movie,
                                    genreText: viewModel.genreNames(for: movie.genreIDs)
                                )
                            }
                        }
                    }
                    .padding()
                    Spacer()
                }
            }
                .onAppear {
                    viewModel.fetchGenres()
                    viewModel.fetchMovies()
                }
            }
        }
    }
}
#Preview {
    MovieListView()
}
