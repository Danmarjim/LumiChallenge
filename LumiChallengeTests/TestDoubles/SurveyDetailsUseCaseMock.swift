class SurveyDetailsUseCaseMock: SurveyDetailsUseCase {
  var result: Result<[SurveyItem], Error> = .success([])
  
  func execute() async throws -> [SurveyItem] {
    switch result {
    case .success(let items):
      return items
      
    case .failure(let error):
      throw error
    }
  }
}
