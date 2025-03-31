import Foundation

class SurveyApiDataSource: SurveyDataSource {
  
  func fetchSurveyDetails() async throws -> [SurveyItem] {
    let url = URL(string: "https://mocki.io/v1/6c823976-465e-401e-ae8d-d657d278e98e")!
    let (data, _) = try await URLSession.shared.data(from: url)
    let decodedResponse = try JSONDecoder().decode(SurveyResponse.self, from: data)
    
    var result: [SurveyItem] = []
    let surveyItem = SurveyItem(
      type: ItemType(rawValue: decodedResponse.type) ?? .page,
      title: decodedResponse.title,
      items: decodedResponse.items
    )
    result.append(surveyItem)
    
    return result
  }
}
