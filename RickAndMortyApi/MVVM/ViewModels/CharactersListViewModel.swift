
import SwiftUI

@MainActor
class CharactersListViewModel: ObservableObject {
    @Published var state: LoadState<[Character]> = .idle
    private let service = APIService()

    func loadCharacters() async {
        state = .loading
        do {
            let list = try await service.fetchCharacters()
            state = list.isEmpty ? .failure("No characters") : .success(list)
        } catch {
            state = .failure(error.localizedDescription)
        }
    }

    func reset() {
        state = .idle
    }
}
