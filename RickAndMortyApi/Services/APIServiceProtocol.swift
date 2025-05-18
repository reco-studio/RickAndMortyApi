
protocol APIServiceProtocol {
    func fetchCharacters(page: Int) async throws -> [Character]
    func fetchEpisode(id: Int) async throws -> Episode
}
