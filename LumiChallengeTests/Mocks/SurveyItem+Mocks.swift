import Foundation

extension SurveyItem {
  static func mock(id: String = UUID().uuidString,
                   type: ItemType,
                   title: String? = nil,
                   text: String? = nil,
                   questionType: QuestionType? = nil,
                   items: [SurveyItem]? = nil) -> SurveyItem {
    SurveyItem(
      id: id,
      type: type,
      title: title,
      text: text,
      questionType: questionType,
      items: items
    )
  }
  
  static var mockSurvey: [SurveyItem] {
    return [
      mock(
        id: "page_1",
        type: .page,
        title: "First Page",
        items: [
          mock(
            type: .section,
            title: "Sectio  A",
            items: [
              mockTextQuestion,
              mockImageQuestion
            ]
          ),
          mockSection
        ]
      ),
      mock(
        id: "page_2",
        type: .page,
        title: "Second Page",
        items: [
          mock(
            type: .section,
            title: "Section B",
            items: [
              mock(
                type: .question,
                text: "Describe your experience",
                questionType: .text
              )
            ]
          )
        ]
      ),
      .mockSection,
      .mockTextQuestion
    ]
  }
  
  static var mockPage: SurveyItem {
    mock(
      id: "page_1",
      type: .page,
      title: "Home page",
      items: [mockSection, mockTextQuestion]
    )
  }
  
  static var mockSection: SurveyItem {
    mock(
      id: "section_1",
      type: .section,
      title: "Personal information",
      items: [mockTextQuestion]
    )
  }
  
  static var mockTextQuestion: SurveyItem {
    mock(
      id: "question_1",
      type: .question,
      text: "¿What's your name?",
      questionType: .text
    )
  }
  
  static var mockImageQuestion: SurveyItem {
    mock(
      id: "question_2",
      type: .question,
      text: "https://images.dog.ceo/breeds/maltese/n02085936_797.jpg",
      questionType: .image
    )
  }
}
