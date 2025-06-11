import Foundation

struct CharactersResponse: Codable, Equatable {
    struct Info: Codable, Equatable {
        let count: Int
        let pages: Int
        let next: String?
        let prev: String?
    }

    let info: Info
    let results: [Character]
}

// Ogólny komentarz

/// Brak uwag.
