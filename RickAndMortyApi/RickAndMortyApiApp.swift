
import SwiftUI

@main
struct RickAndMortyApiApp: App {
    var body: some Scene {
        WindowGroup {
            if #available(iOS 16.0, *) {
                NavigationStack {
                    CharactersListView()
                }
            } else {
                // for iOS 15.0
                NavigationView {
                    CharactersListView()
                }
            }
        }
    }
}
