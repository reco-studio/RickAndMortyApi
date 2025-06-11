import Foundation

struct Character: Codable, Identifiable, Equatable {
    let id: Int
    let name: String
    let status: String
    let species: String
    let type: String
    let gender: String
    let origin: Location
    let location: Location
    let image: URL
    let episode: [URL]
}

struct Location: Codable, Equatable {
    let name: String
    let url: URL?

    enum CodingKeys: String, CodingKey {
        case name, url
    }

    init(name: String, url: URL?) {
        self.name = name
        self.url = url
    }

    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        name = try container.decode(String.self, forKey: .name)
        let urlString = try container.decode(String.self, forKey: .url)

        if urlString.isEmpty {
            url = nil
        } else {
            url = URL(string: urlString)
        }
    }
}

extension Character {
    static let mock = Character(
        id: 1,
        name: "Rick Sanchez",
        status: "Alive",
        species: "Human",
        type: "",
        gender: "Male",
        origin: Location(name: "Earth", url: URL(string: "https://example.com")!),
        location: Location(name: "Citadel of Ricks", url: URL(string: "https://example.com")!),
        image: URL(string: "https://rickandmortyapi.com/api/character/avatar/1.jpeg")!,
        episode: []
    )
}

extension Location {
    var isValidURL: Bool {
        url != nil
    }
}

// Ogólny komentarz

/// Plus za wykorzystanie `CodingKeys`.
