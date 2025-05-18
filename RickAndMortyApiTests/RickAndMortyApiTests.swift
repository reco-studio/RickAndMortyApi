
import Testing
@testable import RickAndMortyApi

struct MockAPIService: APIServiceProtocol {
    func fetchCharacters(page: Int = 1) async throws -> [Character] {
        [.mock]
    }

    func fetchEpisode(id: Int) async throws -> Episode {
        .mock
    }
}

struct RickAndMortyApiTests {
    @Test func testCharactersListViewModelLoadsCharacters() async throws {
        let vm = await CharactersListViewModel(service: MockAPIService())

        await vm.loadCharacters()

        switch await vm.state {
        case .success(let characters):
            #expect(characters.first?.name == "Rick Sanchez")
        default:
            #expect(Bool(false), "Expected .success state with characters")
        }
    }
}
