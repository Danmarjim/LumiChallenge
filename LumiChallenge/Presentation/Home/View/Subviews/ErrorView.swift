import SwiftUI

struct ErrorView: View {
  let error: Error
  
  var body: some View {
    VStack(spacing: 16) {
      Image(systemName: "exclamationmark.triangle")
        .font(.system(size: 48))
        .foregroundColor(.red)
      
      Text("Error Load Survey")
        .font(.headline)

      Text(error.localizedDescription)
        .font(.subheadline)
        .multilineTextAlignment(.center)
    }
    .padding()
  }
}
