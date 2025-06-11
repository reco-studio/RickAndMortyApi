import SwiftUI

struct LoadingView: View {
    let text: String

    init(_ text: String = " Loading... ") {
        self.text = text
    }

    var body: some View {
        VStack(spacing: 8) {
            ProgressView()
            Text(text)
                .font(.caption)
                .foregroundColor(.secondary)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
    }
}

#if DEBUG
#Preview {
    LoadingView()
}
#endif

// Ogólny komentarz

/// Brak uwag.
