
import SwiftUI

@MainActor
class CharacterDetailsViewModel: ObservableObject {

    @Published var state: LoadState<Character> = .idle
    @Published var episodes: LoadState<[Episode]> = .idle
    private let service = APIService()

    func load(character: Character) async {
        state = .success(character)
        episodes = .loading
        var list: [Episode] = []
        for url in character.episode {
            if let id = Int(url.lastPathComponent) {
                do {
                    let ep = try await service.fetchEpisode(id: id)
                    list.append(ep)
                } catch {
                    episodes = .failure(error.localizedDescription)
                    return
                }
            }
        }
        episodes = .success(list)
    }
}
