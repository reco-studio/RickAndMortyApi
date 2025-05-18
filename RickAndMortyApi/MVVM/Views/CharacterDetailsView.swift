
import SwiftUI

struct CharacterDetailsView: View {
    let character: Character
    @StateObject private var vm = CharacterDetailsViewModel()

    var body: some View {
        ScrollView {
            VStack(spacing: 12) {
                AsyncImage(url: character.image) { img in img.resizable()
                    .scaledToFit() }
                placeholder: {
                    ProgressView()
                }
                Text(" Status: \(character.status)")
                Text(" Gender: \(character.gender)")
                Text(" Origin: \(character.origin.name)")
                Text(" Location: \(character.location.name)")

                Divider()

                switch vm.episodes {
                case .idle:
                    LoadingView("Loading episodes")
                case .loading:
                    LoadingView("Loading episodes")
                case .success(let eps):
                    ForEach(eps) { ep in
                        NavigationLink(destination: EpisodeDetailsView(episodeID: ep.id)) {
                            Text("Episode \(ep.episode)")
                        }
                    }
                case .failure(let msg):
                    ErrorView(message: msg) { Task { await vm.load(character: character) } }
                }
            }
            .padding()
        }
        .navigationTitle(character.name)
        .task { await vm.load(character: character) }
    }
}

#Preview {
    CharacterDetailsView(character: .mock)
}

