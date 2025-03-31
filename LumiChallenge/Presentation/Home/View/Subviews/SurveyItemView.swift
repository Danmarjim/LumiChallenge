import SwiftUI

struct SurveyItemView: View {
  let item: SurveyItem
  
  private var fontSize: CGFloat {
    switch item.type {
    case .page:
      return 26
      
    case .section:
      return 17
      
    case .text, .image:
      return 15
    }
  }
  
  private var fontWeight: Font.Weight {
    switch item.type {
    case .page:
      return .bold
      
    case .section:
      return .regular
      
    case .text, .image:
      return .thin
    }
  }
  
  private var iconName: String {
    switch item.type {
    case .page: 
      return "doc.text"
      
    case .section:
      return "folder"
      
    case .text:
      return "questionmark.circle"
      
    case .image:
      return "photo"
    }
  }
  
  var body: some View {
    HStack(spacing: 12) {
      Image(systemName: iconName)
        .foregroundColor(.primary)
        .frame(width: 24)
      
      if item.type == .image, let imageUrl = item.src {
        AsyncImage(url: URL(string: imageUrl)) { image in
          image
            .resizable()
            .scaledToFit()
            .frame(height: 60)
            .clipShape(RoundedRectangle(cornerRadius: 8))
        } placeholder: {
          ProgressView()
            .frame(height: 60)
        }
      } else {
        Text(item.displayText)
          .font(.system(size: fontSize))
          .fontWeight(fontWeight)
          .foregroundColor(.primary)
      }
    }
    .padding(.vertical, 4)
  }
}
