import SwiftUI

@MainActor
class CharactersListViewModel: ObservableObject {
    @Published var state: LoadState<[Character]> = .idle
    private let service = APIService()

    func loadCharacters() async {
        state = .loading
        do {
            let characters = try await service.fetchCharacters()
            state = characters.isEmpty ? .failure("No characters") : .success(characters)
        } catch {
            state = .failure(error.localizedDescription)
        }
    }

    func reset() {
        state = .idle
    }
}

// Ogólny komentarz

/// Brak uwag.
