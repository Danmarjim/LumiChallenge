struct SurveyRepository {
  private let apiDataSource: SurveyDataSource
  
  init(apiDataSource: SurveyDataSource) {
    self.apiDataSource = apiDataSource
  }
  
  func fetchSurveyDetails() async throws -> [SurveyItem] {
    try await apiDataSource.fetchSurveyDetails()
  }
}
