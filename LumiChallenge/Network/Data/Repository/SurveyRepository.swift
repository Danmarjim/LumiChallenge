struct SurveyRepository {
  private let remoteDataSource: SurveyDataSource
  private let localStorage: SurveyLocalStorage
  
  init(remoteDataSource: SurveyDataSource,
       localStorage: SurveyLocalStorage = UserDefaultsDataStorage()) {
    self.remoteDataSource = remoteDataSource
    self.localStorage = localStorage
  }
  
  func fetchSurveyDetails() async throws -> [SurveyItem] {
    do {
      let remoteItems = try await remoteDataSource.fetchSurveyDetails()
      try await localStorage.saveSurveys(remoteItems)
      return remoteItems
    } catch {
      let localItems = try await localStorage.loadSurveys()
      if !localItems.isEmpty {
        return localItems
      }
      throw error
    }
  }
}
