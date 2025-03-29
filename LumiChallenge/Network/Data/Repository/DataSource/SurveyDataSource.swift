protocol SurveyDataSource {
  func fetchSurveyDetails() async throws -> [SurveyItem]
}
