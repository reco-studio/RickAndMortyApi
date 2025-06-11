import SwiftUI

struct EpisodeDetailsView: View {
    @StateObject private var viewModel: EpisodeDetailsViewModel

    init(episodeID: Int) {
        _viewModel = StateObject(wrappedValue: EpisodeDetailsViewModel(episodeID: episodeID))
    }

    var body: some View {
        Group {
            switch viewModel.state {
            case .idle, .loading:
                LoadingView("Loading episode")
            case let .failure(message):
                ErrorView(message: message) {
                    Task { await viewModel.load() }
                }
            case let .success(episode):
                VStack(alignment: .leading, spacing: 8) {
                    Text(episode.name)
                        .font(.title2)
                    Text("Air date: \(episode.air_date)")
                    Text("Episode: \(episode.episode)")
                    Text("Characters: \(episode.characters.count)")
                }
                .padding()
                .frame(maxHeight: .infinity, alignment: .top)
            }
        }
        .navigationTitle("Episode")
        .task { await viewModel.load() }
    }
}

#if DEBUG
#Preview {
    EpisodeDetailsView(episodeID: 1)
}
#endif

// Ogólny komentarz

/// Fajnie że na `init` przekazujesz `episodeID` na podstawie którego budujesz ViewModel, można pójść o krok dalej i podczas inicjalizacji podawać jako parametr, cały ViewModel.
