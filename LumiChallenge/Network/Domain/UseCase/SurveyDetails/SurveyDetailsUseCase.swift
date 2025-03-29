protocol SurveyDetailsUseCase {
  func execute() async throws -> [SurveyItem]
}
