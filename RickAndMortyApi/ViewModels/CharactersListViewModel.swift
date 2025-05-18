
import SwiftUI

@MainActor
class CharactersListViewModel: ObservableObject {
    @Published var state: LoadState<[Character]> = .idle
    private let service: APIServiceProtocol

    init(service: APIServiceProtocol = APIService()) {
        self.service = service
    }

    func loadCharacters(page: Int = 1) async {
        state = .loading
        do {
            let list = try await service.fetchCharacters(page: page)
            state = list.isEmpty ? .failure("No characters") : .success(list)
        } catch {
            state = .failure(error.localizedDescription)
        }
    }

    func reset() {
        state = .idle
    }
}
