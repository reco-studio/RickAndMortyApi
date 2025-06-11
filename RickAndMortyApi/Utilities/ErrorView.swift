import SwiftUI

struct ErrorView: View {
    let message: String
    let retry: () -> Void

    var body: some View {
        VStack(spacing: 16) {
            Text("Error:")
                .font(.headline)
            Text(message)
                .multilineTextAlignment(.center)
            Button ("Try again", action: retry)
                .padding()
                .background(Color.blue)
                .foregroundColor(.white)
                .clipShape(.rect(cornerRadius: 8))
        }
        .padding()
        .frame(maxWidth: .infinity, maxHeight: .infinity)
    }
}

#if DEBUG
#Preview {
    ErrorView(
        message: "Something went wrong",
        retry: { print("Retry button tapped in preview") }
    )
}
#endif

// Ogólny komentarz

/// Brak uwag.
