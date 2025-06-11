import SwiftUI

struct CharactersListView: View {
    @StateObject private var viewModel = CharactersListViewModel()

    var body: some View {
        VStack {
            switch viewModel.state {
            case .idle:
                VStack {
                    Text("Push to load characters")
                    Button("Load") {
                        Task { await viewModel.loadCharacters() }
                    }
                }
            case .loading:
                LoadingView()
            case let .success(characters):
                List(characters) { character in
                    NavigationLink(destination: CharacterDetailsView(character: character)) {
                        CharacterRowView(character: character)
                    }
                }
            case let .failure(message):
                ErrorView(message: message) {
                    Task { await viewModel.loadCharacters() }
                }
            }
        }
        .navigationTitle("Characters")
        .toolbar {
            Button("Reset") { viewModel.reset() }
        }
    }
}

#if DEBUG
#Preview {
    CharactersListView()
}
#endif

// Ogólny komentarz

/// W case gdzie mamy `associatedValue` lepszym pomysłem jest wyniesienie let przed cały case, wtedy jeżeli enum ma więcej niż jedną `associatedValue` to nie musimy dublować `let` przed każdą wartością. Bardzo istotne - używaj pełnych nazw i nazywaj elementy adekwatnie do tego czym są `'list' -> 'characters'`.
