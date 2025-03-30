import Foundation

class SurveyApiDataSource: SurveyDataSource {
  
  func fetchSurveyDetails() async throws -> [SurveyItem] {
    let url = URL(string: "https://run.mocky.io/v3/336840e1-c5e8-4bd1-b7ce-448ca69e2f6d")!
    let (data, _) = try await URLSession.shared.data(from: url)
    let decodedResponse = try JSONDecoder().decode(SurveyResponse.self, from: data)
    
    return decodedResponse.items
  }
}
