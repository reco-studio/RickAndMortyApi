import SwiftUI

struct CharacterRowView: View {
    let character: Character

    var body: some View {
        HStack {
            AsyncImage(url: character.image) { image in
                image
                    .resizable()
                    .scaledToFill()
                    .frame(width: 50, height: 50)
                    .clipShape(.circle)
            } placeholder: {
                ProgressView()
            }
            Text(character.name)
            .frame(maxWidth: .infinity, alignment: .leading)
        }
        .padding(.vertical, 8)
    }
}

#if DEBUG
#Preview {
    CharacterRowView(character: .mock)
}
#endif

// Ogólny komentarz

/// Warto nadać dla `ProgressView` ten sam rozmiar co dla obrazka, przez co przy wczytywaniu imię bohatera nie będzie przeskakiwać, reszta kwestii wyjaśniona w komentarzu do `EpisodeRowView` oraz `CharactersListView`.
