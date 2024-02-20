import SwiftUI

struct MainView: View {
    var body: some View {
        TabView {
            MovieView(viewModel: MoviesViewModel.make())
                .tabItem {
                    Label("Movies", systemImage: "film")
                }

            TVShowsView(viewModel: TvShowListViewModel.make())
                .tabItem {
                    Label("TV Shows", systemImage: "tv")
                }
        }
    }
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
    }
}
