import Foundation

struct SurveyImageItem: Identifiable {
  let id = UUID()
  let title: String
  let imageUrl: String
}

// MARK: - Mock
extension SurveyImageItem {
  static var mock: SurveyImageItem {
    return SurveyImageItem(
      title: "Mock",
      imageUrl: "https://images.dog.ceo/breeds/maltese/n02085936_797.jpg"
    )
  }
}
