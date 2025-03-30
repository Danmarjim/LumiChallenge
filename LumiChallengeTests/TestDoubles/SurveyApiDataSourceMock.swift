import Foundation

class SurveyApiDataSourceMock: SurveyDataSource {
  var surveyItems: [SurveyItem] = []
  var shouldThrowError = false
  
  func fetchSurveyDetails() async throws -> [SurveyItem] {
    if shouldThrowError {
      throw NSError(
        domain: "TestError",
        code: 500,
        userInfo: nil
      )
    }
    return surveyItems
  }
}
