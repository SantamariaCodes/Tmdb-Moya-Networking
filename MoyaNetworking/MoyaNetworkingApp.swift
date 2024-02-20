// MoyaNetworkingApp.swift
// Responsible for initializing and wiring up the application's dependencies. It creates instances of NetworkManager, MovieService, and MovieViewModel, injecting them where needed to facilitate the flow of data from the network to the UI.

import SwiftUI

@main

struct MoyaNetworkingApp: App {
    var body: some Scene {
        WindowGroup {
            
            // ver como funciona el cyclo de vida de Swift Ui como se actualiza la info visual
            // Injecting both ViewModels into ContentView
            //dependency inj da la libertad de poder pasar parametros en este caso a viewmodel.
            // haacer lo mismo para TvShows, ver porque no funciona tv shows, implementar details para endpoint y otra view para details y despues de Swift UI
            // Dependencies for TV shows
         
           // ContentView(viewModel: MoviesViewModel.make())
         //   TVShowsView(viewModel: TvShowListViewModel.make())
                    MainView()
                     }
    }
}
