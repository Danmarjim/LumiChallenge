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
  var items: [SurveyItem]?
  
  var nestingLevel: Int {
    guard let items = items else { return 0 }
    return items.compactMap { $0.nestingLevel }.max().map { $0 + 1 } ?? 0
  }
  
  var displayText: String {
    switch type {
    case .page, .section: return title ?? "No title"
    case .question: return text ?? "Question without text"
    }
  }
  
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

// MARK: - Sorting
extension SurveyItem {
  
  var sortingPriority: Int {
    switch type {
    case .page: return 0
    case .section: return 1
    case .question: return 2
    }
  }
  
  static func sortSurveyItems(_ items: [SurveyItem]) -> [SurveyItem] {
    return items.sorted { $0.sortingPriority < $1.sortingPriority }.map { item in
      var sortedItem = item
      if let nestedItems = item.items {
        sortedItem.items = sortSurveyItems(nestedItems)
      }
      return sortedItem
    }
  }
}
