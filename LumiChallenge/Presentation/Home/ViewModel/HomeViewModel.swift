import SwiftUI

@MainActor
class HomeViewModel: ObservableObject {
  @Published var items: [SurveyItem] = []
  @Published var isLoading = false
  @Published var serviceError: Error?
  
  private let surveyDetails: SurveyDetailsUseCase
  
  init(surveyDetails: SurveyDetailsUseCase = NetworkService.shared.surveyDetails) {
    self.surveyDetails = surveyDetails
    Task {
      await fetchSurveyDetails()
    }
  }
  
  func fetchSurveyDetails() async {
    isLoading = true
    defer { isLoading = false }
    
    do {
      items = SurveyItem.sortSurveyItems(try await surveyDetails.execute())
    } catch {
      handleError(error)
    }
  }
}

// MARK: - Private methods
extension HomeViewModel {
  
  private func handleError(_ error: Error) {
    serviceError = error
  }
}
