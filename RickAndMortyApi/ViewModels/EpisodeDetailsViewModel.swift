
import SwiftUI

@MainActor
class EpisodeDetailsViewModel: ObservableObject {
    @Published var state: LoadState<Episode> = .idle
    private let service = APIService()
    private let episodeID: Int

    init(episodeID: Int) {
        self.episodeID = episodeID
    }

    func load() async {
        state = .loading
        do {
            let ep = try await service.fetchEpisode(id: episodeID)
            state = .success(ep)
        } catch {
            state = .failure(error.localizedDescription)
        }
    }
}
