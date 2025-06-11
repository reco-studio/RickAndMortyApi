import Foundation

struct Episode: Codable, Identifiable, Equatable {
    let id: Int
    let name: String
    let air_date: String
    let episode: String
    let characters: [URL]
}

extension Episode {
    static let mock = Episode(
        id: 1,
        name: "Pilot",
        air_date: "December 2, 2013",
        episode: "S01E01",
        characters: []
    )
}

// Ogólny komentarz

/// Przydałoby się skorzystać z `CodingKeys` również tutaj, tak aby wszystkie nazwy mieć w postaci `snakeCase`. `air_date -> airDate`.
