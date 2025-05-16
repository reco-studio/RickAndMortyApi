
import SwiftUI

struct EpisodeDetailsView: View {
    @StateObject private var vm: EpisodeDetailsViewModel

    init(episodeID: Int) {
        _vm = StateObject(wrappedValue: EpisodeDetailsViewModel(episodeID: episodeID))
    }

    var body: some View {
        Group {
            switch vm.state {
            case .idle, .loading:
                LoadingView("Loading episode")
            case .failure(let msg):
                ErrorView(message: msg) {
                    Task { await vm.load() }
                }
            case .success(let ep):
                VStack(alignment: .leading, spacing: 8) {
                    Text(ep.name)
                        .font(.title2)
                    Text("Air date: \(ep.air_date)")
                    Text("Episode: \(ep.episode)")
                    Text("Characters: \(ep.characters.count)")
                    Spacer()
                }
                .padding()
            }
        }
        .navigationTitle("Episode")
        .task { await vm.load() }
    }
}

#Preview {
    EpisodeDetailsView(episodeID: 1)
}

