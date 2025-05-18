
import Foundation

final class APIService {
    private let baseURL = "https://rickandmortyapi.com/api"

    private func request<T: Decodable>(_ url: URL) async throws -> T {
        let (data, response) = try await URLSession.shared.data(from: url)
        guard let http = response as? HTTPURLResponse, http.statusCode == 200 else {
            throw URLError(.badServerResponse)
        }
        do {
            return try JSONDecoder().decode(T.self, from: data)
        } catch {
            print("❌ Decoding error for \(T.self): \(error)")
            if let raw = String(data: data, encoding: .utf8) {
                print("🔍 Raw JSON:\n\(raw)")
            }
            throw error
        }
    }
    
    func fetchCharacters(page: Int = 1) async throws -> [Character] {
        guard let url = URL(string: "\(baseURL)/character?page=\(page)") else {
            throw URLError(.badURL)
        }
        let wrapper: CharactersResponse = try await request(url)
        return wrapper.results
    }

    func fetchEpisode(id: Int) async throws -> Episode {
        guard let url = URL(string: "\(baseURL)/episode/\(id)") else {
            throw URLError(.badURL)
        }
        return try await request(url)
    }
}
