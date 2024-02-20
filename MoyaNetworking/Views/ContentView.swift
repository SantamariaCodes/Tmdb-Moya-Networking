import SwiftUI

struct ContentView: View {
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


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView(viewModel: MoviesViewModel(movieService: MovieListService(networkManager: NetworkManager<MovieListTarget>())))
    }
}
