import XCTest
@testable import LumiChallenge

@MainActor
class HomeViewModelSpec: XCTestCase {
  
  var viewModel: HomeViewModel!
  var mockUseCase: SurveyDetailsUseCaseMock!
  
  override func setUp() {
    super.setUp()
    mockUseCase = SurveyDetailsUseCaseMock()
    viewModel = HomeViewModel(surveyDetails: mockUseCase)
  }
  
  override func tearDown() {
    viewModel = nil
    mockUseCase = nil
    super.tearDown()
  }
  
  func test_initial_state() {
    thenInitialState()
  }
  
  func test_fetch_details_success() async {
    givenSurveyDetails()
    await whenFetchSurveyDetails()
    thenSuccessFetchSurveyDetails()
  }
  
  func test_fetch_details_failure() async {
    givenError()
    await whenFetchSurveyDetails()
    thenFailureFetchSurveyDetails()
  }
}

// MARK: - GIVEN
extension HomeViewModelSpec {
  
  private func givenSurveyDetails() {
    let mockItems = [
      SurveyItem(id: UUID().uuidString, type: .page),
      SurveyItem(id: UUID().uuidString, type: .page)
    ]
    mockUseCase.result = .success(mockItems)
  }
  
  private func givenError() {
    let testError = NSError(domain: "TestError", code: 500, userInfo: nil)
    mockUseCase.result = .failure(testError)
  }
}

// MARK: - WHEN
extension HomeViewModelSpec {
  
  private func whenFetchSurveyDetails() async {
    await viewModel.fetchSurveyDetails()
  }
}

// MARK: - THEN
extension HomeViewModelSpec {
  
  private func thenInitialState() {
    XCTAssertFalse(viewModel.isLoading)
    XCTAssertTrue(viewModel.items.isEmpty)
    XCTAssertNil(viewModel.serviceError)
  }
  
  private func thenSuccessFetchSurveyDetails() {
    XCTAssertFalse(viewModel.isLoading)
    XCTAssertEqual(viewModel.items.count, 2)
    XCTAssertNil(viewModel.serviceError)
  }
  
  private func thenFailureFetchSurveyDetails() {
    XCTAssertFalse(viewModel.isLoading)
    XCTAssertTrue(viewModel.items.isEmpty)
    XCTAssertNotNil(viewModel.serviceError)
  }
}
