
import SwiftUI

struct CharactersListView: View {
    @StateObject private var vm = CharactersListViewModel()
    
    var body: some View {
        VStack {
            switch vm.state {
            case .idle:
                VStack {
                    Text("Push to load characters")
                    Button("Load") {
                        Task { await vm.loadCharacters() }
                    }
                }
            case .loading:
                LoadingView()
            case .success(let list):
                List(list) { char in
                    NavigationLink(destination: CharacterDetailsView(character: char)) {
                        CharacterRowView(character: char)
                    }
                }
            case .failure(let msg):
                ErrorView(message: msg) {
                    Task { await vm.loadCharacters() }
                }
            }
        }
        .navigationTitle("Characters")
        .toolbar {
            Button("Reset") {
                vm.reset()
            }
        }
    }
}

#Preview {
    CharactersListView()
}
