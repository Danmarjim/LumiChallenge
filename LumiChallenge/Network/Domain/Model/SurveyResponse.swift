struct SurveyResponse: Codable {
  let type: String
  let title: String
  let items: [SurveyItem]
  
  enum CodingKeys: String, CodingKey {
    case type, title, items
  }
}
