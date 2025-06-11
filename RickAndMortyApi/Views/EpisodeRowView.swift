import SwiftUI

struct EpisodeRowView: View {
    let episode: Episode

    var body: some View {
        HStack {
            Text(episode.episode)
            Text(episode.name)
                .foregroundColor(.secondary)
                .frame(maxWidth: .infinity, alignment: .leading)
        }
        .padding(.vertical, 4)
    }
}

#if DEBUG
#Preview {
    EpisodeRowView(episode: .mock)
}
#endif

// Ogólny komentarz

/// Super, że używasz mocków w `#Preview`, warto też `#Preview` opakować w `#if DEBUG`, skróci to czas kompilacji i lepiej zoptymalizuje wersję produkcyjną. Co do samego kodu w tym pliku jeżeli masz możliwość wykorzystać `.frame()` z odpowiednimi parametrami to zawsze to będzie lepszym rozwiązaniem niż używanie Spacerów. W ten sposób nie dodajesz kolejnego elementu na widoku.
/// Warto pomyśleć też nad wyniesieniem wszystkich stałych używanych do paddingów do osobnego pliku jako extension do `CGFloat` i nadanie im nazw w oparciu o tokeny, np. `padding2, padding8, padding24, etc.` Wtedy masz spójność w całym projekcie.
/// Warto też pomyśleć nad jakimś globalnym podejściem do nowych linii w projekcie, powinny one zwiększać czytelność przede wszystkim.
