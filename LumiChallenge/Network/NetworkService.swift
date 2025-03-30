class NetworkService {
  static let shared = NetworkService()
}

extension NetworkService {
  
  var surveyDetails: SurveyDetailsUseCase {
    return SurveyDetails(surveyRepository: surveyRepository)
  }
  
  var surveyRepository: SurveyRepository {
    return SurveyRepository(remoteDataSource: SurveyApiDataSource())
  }
}
