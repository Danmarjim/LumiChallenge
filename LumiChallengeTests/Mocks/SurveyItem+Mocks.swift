import Foundation

extension SurveyItem {
  static func mock(id: String = UUID().uuidString,
                   type: ItemType,
                   title: String? = nil,
                   text: String? = nil,
                   src: String? = nil,
                   items: [SurveyItem]? = nil) -> SurveyItem {
    SurveyItem(
      type: type,
      title: title,
      text: text,
      src: src,
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
                    type: .text,
                    text: "Describe your experience"
                  )
                ]
              )
            ]
          ),
          mockSection,
          mockTextQuestion,
          mockSection
        ]
      )
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
      type: .text,
      text: "¿What's your name?"
    )
  }
  
  static var mockImageQuestion: SurveyItem {
    mock(
      id: "question_2",
      type: .image,
      text: "https://images.dog.ceo/breeds/maltese/n02085936_797.jpg"
    )
  }
}
