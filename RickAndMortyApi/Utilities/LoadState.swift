import Foundation

enum LoadState<Success> {
    case idle
    case loading
    case success(Success)
    case failure(String)
}

// Ogólny komentarz

/// Brak uwag.
