
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
                    .clipShape(Circle())
            } placeholder: {
                ProgressView()
            }
            Text(character.name)
            Spacer()
        }
        .padding(.vertical, 8)
    }
}

#Preview {
    CharacterRowView(character: .mock)
}
