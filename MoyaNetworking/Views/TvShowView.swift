import SwiftUI

struct TVShowsView: View {
    @StateObject var viewModel: TvShowListViewModel // Assume this is initialized elsewhere, like in your App or Scene delegate
    @State private var selectedListType: TvShowListTarget = .topRated // Default to popular TV shows

    var body: some View {
        NavigationView {
            VStack {
                Picker("Select List Type", selection: $selectedListType) {
                    Text("Popular").tag(TvShowListTarget.popular)
                    Text("Airing Today").tag(TvShowListTarget.airingToday)
                    Text("On The Air").tag(TvShowListTarget.onTheAir)
                    Text("Top Rated").tag(TvShowListTarget.topRated)
                }
                .pickerStyle(SegmentedPickerStyle())
                .padding()

                List(viewModel.tvShows, id: \.id) { tvShow in
                    VStack(alignment: .leading) {
                        Text(tvShow.title)
                            .font(.headline)
                        Text(tvShow.overview)
                            .font(.subheadline)
                    }
                }
            }
            .navigationBarTitle("TV Shows")
            .onAppear {
                viewModel.loadTvShows(listType: selectedListType)
            }
            .onChange(of: selectedListType) { newValue in
                viewModel.loadTvShows(listType: newValue)
            }
        }
    }
}

// Example preview for TVShowsView
struct TVShowsView_Previews: PreviewProvider {
    static var previews: some View {
        TVShowsView(viewModel: TvShowListViewModel(tvService: TvShowListService (networkManager: NetworkManager<TvShowListTarget>())))
    }
}


