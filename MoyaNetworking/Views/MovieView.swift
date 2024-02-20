//
//  MovieView.swift
//  MoyaNetworking
//
//  Created by Diego Santamaria on 19/2/24.
//

import SwiftUI

struct MovieView: View {
    @StateObject var viewModel: MoviesViewModel
    @State private var selectedListType: MovieListTarget = .popularMovies

    var body: some View {
        NavigationView {
            VStack {
                Picker("Select List Type", selection: $selectedListType) {
                    Text("Popular").tag(MovieListTarget.popularMovies)
                    Text("Top Rated").tag(MovieListTarget.topRated)
                    Text("Upcoming").tag(MovieListTarget.upComing)
                    Text("Now Playing").tag(MovieListTarget.nowPlaying)
                }
                .pickerStyle(SegmentedPickerStyle())
                .padding()

                List(viewModel.movies, id: \.id) { movie in
                    VStack(alignment: .leading) {
                        Text(movie.title)
                            .font(.headline)
                        Text(movie.overview)
                            .font(.subheadline)
                    }
                }
            }
            .navigationBarTitle("Movies")
            .onAppear {
                viewModel.loadMovies(listType: selectedListType)
            }
            .onChange(of: selectedListType) { newValue in
                viewModel.loadMovies(listType: newValue)
            }
        }
    }
}

// Update the preview provider to reflect the new name
struct MovieView_Previews: PreviewProvider {
    static var previews: some View {
        MovieView(viewModel: MoviesViewModel(movieService: MovieListService(networkManager: NetworkManager<MovieListTarget>())))
    }
}
