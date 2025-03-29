import Foundation

class SurveyApiDataSource: SurveyDataSource {
  
  func fetchSurveyDetails() async throws -> [SurveyItem] {
    let url = URL(string: "https://run.mocky.io/v3/e299ee68-8ad1-4b8a-a234-6173637a8b2c")!
    let (data, _) = try await URLSession.shared.data(from: url)
    let decodedResponse = try JSONDecoder().decode(SurveyResponse.self, from: data)
    
    return decodedResponse.items
  }
}
