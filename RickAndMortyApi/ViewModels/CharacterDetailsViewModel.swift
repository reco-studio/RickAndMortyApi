import SwiftUI

@MainActor
class CharacterDetailsViewModel: ObservableObject {
    @Published var state: LoadState<Character> = .idle
    @Published var episodes: LoadState<[Episode]> = .idle
    private let service = APIService()

    func load(character: Character) async {
        state = .success(character)
        episodes = .loading
        var episodesList: [Episode] = []
        for url in character.episode {
            if let id = Int(url.lastPathComponent) {
                do {
                    let episode = try await service.fetchEpisode(id: id)
                    episodesList.append(episode)
                } catch {
                    episodes = .failure(error.localizedDescription)
                    return
                }
            }
        }
        episodes = .success(episodesList)
    }
}

// Ogólny komentarz

/// ViewModel jeszcze lepiej obrazuje dlaczego widok nie powinien trzymać zmiennej `Character`, jak widzisz tutaj używasz tego parametru do zarządzania logiką biznesową, w tym przypadku pobraniem listy odcinków.
/// Po drugie dlaczego state jest typu `LoadState<Character>` skoro jedyny moźliwy `State` do osiągnięcia to `success`? Wystarczy na `init` viewModelu przekazać model `character`.
/// Nie potrzebujesz również pobierać odcinków w tym ViewModelu, tym bardziej że robiąc to przy użyciu pętli `for` jest to mało optymalne wydajnościowo rozwiązanie. Dlatego zadanie wspomina aby nazwy odcinków prezentować w postaci `Odcinek XX` ponieważ numer odcinka jesteś w stanie wyciągnąć z `URL`.
