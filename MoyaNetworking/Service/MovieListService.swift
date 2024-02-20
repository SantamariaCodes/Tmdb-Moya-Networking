// MovieService.swift
//Handles fetching movie data from the network, abstracting the specifics of which network operations are performed.Implements MovieServiceProtocol, allowing for decoupled and testable code by abstracting the service implementation from its consumers (e.g., view models). It uses NetworkManager to fetch data based on MovieTarget..MovieService uses NetworkManager to execute a network request based on MovieTarget
import Foundation

protocol MovieListServiceProtocol {
    func fetchMovies(listType: MovieListTarget, completion: @escaping (Result<[Movie], Error>) -> Void)
}

class MovieListService: MovieListServiceProtocol {
    private var networkManager: NetworkManager<MovieListTarget>
    
    init(networkManager: NetworkManager<MovieListTarget>) {
        self.networkManager = networkManager
    }
    
    func fetchMovies(listType: MovieListTarget, completion: @escaping (Result<[Movie], Error>) -> Void) {
        networkManager.request(target: listType) { (result: Result<MovieListResponse, Error>) in
            switch result {
            case .success(let movieResponse):
                completion(.success(movieResponse.results))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}


