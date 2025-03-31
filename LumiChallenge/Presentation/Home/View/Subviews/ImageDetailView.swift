import SwiftUI

struct ImageDetailView: View {
  let item: SurveyImageItem
  
  var body: some View {
    NavigationStack {
      VStack {
        AsyncImage(url: URL(string: item.imageUrl)) { phase in
          switch phase {
          case .success(let image):
            image
              .resizable()
              .scaledToFit()
            
          case .failure:
            Image(systemName: "photo")
              .resizable()
              .scaledToFit()
              .foregroundColor(.gray)
            
          case .empty:
            ProgressView()
            
          @unknown default:
            EmptyView()
          }
        }
        .padding()
        
        Text(item.title)
          .font(.headline)
          .padding()
      }
      .navigationTitle("Detalle de imagen")
      .navigationBarTitleDisplayMode(.inline)
    }
  }
}
