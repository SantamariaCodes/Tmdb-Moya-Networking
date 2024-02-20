// MovieViewModel.swift

//Purpose: This pattern follows the Dependency Injection principle, which facilitates testing and decouples the MovieViewModel from a concrete MovieService implementation. By injecting MovieServiceProtocol, you can easily swap out the movie service for a mock version when testing or if you decide to change the underlying service implementation later.
//Why: Dependency Injection here allows for greater flexibility and modularity in your app's design. It makes MovieViewModel more testable by allowing you to inject a mock service that conforms to MovieServiceProtocol, simplifying unit tests by controlling the environment in which your view model operates.
import Foundation

class MoviesViewModel: ObservableObject {
    @Published var movies: [Movie] = []
    private let movieService: MovieListServiceProtocol

    init(movieService: MovieListServiceProtocol) {
        self.movieService = movieService
    }

    func loadMovies(listType: MovieListTarget) {
        movieService.fetchMovies(listType: listType) { [weak self] result in
            DispatchQueue.main.async {
                switch result {
                case .success(let movies):
                    self?.movies = movies
                case .failure(let error):
                    print("Error: \(error.localizedDescription)")
                }
            }
        }
    }
}

extension MoviesViewModel {
    static func make() -> MoviesViewModel {
    
        let movieNetworkManager = NetworkManager<MovieListTarget>()
        let movieService = MovieListService(networkManager: movieNetworkManager)
      return MoviesViewModel(movieService: movieService)
    }
}
