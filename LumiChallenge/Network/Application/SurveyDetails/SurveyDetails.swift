struct SurveyDetails: SurveyDetailsUseCase {
  private let surveyRepository: SurveyRepository
  
  init(surveyRepository: SurveyRepository) {
    self.surveyRepository = surveyRepository
  }
  
  func execute() async throws -> [SurveyItem] {
    try await surveyRepository.fetchSurveyDetails()
  }
}
