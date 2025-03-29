enum ItemType: String, Codable {
  case page
  case section
  case question
}

enum QuestionType: String, Codable {
  case text
  case image
}

struct SurveyItem: Codable, Identifiable {
  let id: String
  let type: ItemType
  let title: String?
  let text: String?
  let questionType: QuestionType?
  let items: [SurveyItem]?
  
  private enum CodingKeys: String, CodingKey {
    case type, id, title, text
    case questionType = "questionType"
    case items
  }
  
  init(from decoder: Decoder) throws {
    let container = try decoder.container(keyedBy: CodingKeys.self)
    type = try container.decode(ItemType.self, forKey: .type)
    id = try container.decode(String.self, forKey: .id)
    title = try container.decodeIfPresent(String.self, forKey: .title)
    text = try container.decodeIfPresent(String.self, forKey: .text)
    questionType = try container.decodeIfPresent(QuestionType.self, forKey: .questionType)
    items = try container.decodeIfPresent([SurveyItem].self, forKey: .items)
  }
}

extension SurveyItem {
  var isQuestion: Bool {
    return type == .question
  }
  
  var displayText: String? {
    return isQuestion ? text : title
  }
}
