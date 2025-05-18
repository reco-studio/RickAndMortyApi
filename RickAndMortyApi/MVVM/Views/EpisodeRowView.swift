
import SwiftUI

struct EpisodeRowView: View {
    let episode: Episode
    var body: some View {
        HStack {
            Text(episode.episode)
            Text(episode.name)
                .foregroundColor(.secondary)
            Spacer()
        }
        .padding(.vertical, 4)
    }
}

#Preview {
    EpisodeRowView(episode: .mock)
}
