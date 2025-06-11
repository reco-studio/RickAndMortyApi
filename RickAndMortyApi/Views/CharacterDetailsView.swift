import SwiftUI

struct CharacterDetailsView: View {
    let character: Character
    @StateObject private var viewModel = CharacterDetailsViewModel()

    var body: some View {
        ScrollView {
            VStack(spacing: 12) {
                AsyncImage(url: character.image) { image in
                    image
                        .resizable()
                        .scaledToFit()
                }
                placeholder: {
                    ProgressView()
                }
                Text("Status: \(character.status)")
                Text("Gender: \(character.gender)")
                Text("Origin: \(character.origin.name)")
                Text("Location: \(character.location.name)")

                Divider()

                switch viewModel.episodes {
                case .idle, .loading:
                    LoadingView("Loading episodes")
                case let .success(episodes):
                    ForEach(episodes) { episode in
                        NavigationLink(destination: EpisodeDetailsView(episodeID: episode.id)) {
                            Text("Episode \(episode.episode)")
                        }
                    }
                case let .failure(message):
                    ErrorView(message: message) {
                        Task { await viewModel.load(character: character) }
                    }
                }
            }
            .padding()
        }
        .navigationTitle(character.name)
        .task { await viewModel.load(character: character) }
    }
}

#if DEBUG
#Preview {
    CharacterDetailsView(character: .mock)
}
#endif

// Ogólny komentarz

/// Widok nie powinien trzymać żadnych modelów danych, `character` powinien wylądować w ViewModelu.
