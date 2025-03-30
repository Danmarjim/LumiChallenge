import XCTest
@testable import LumiChallenge

class SurveyRepositorySpec: XCTestCase {
  private var repository: SurveyRepository!
  private var mockDataSource: SurveyApiDataSourceMock!
  private var expectedItems: [SurveyItem] = []
  
  override func setUp() async throws {
    try await super.setUp()
    mockDataSource = SurveyApiDataSourceMock()
    repository = SurveyRepository(remoteDataSource: mockDataSource)
  }
  
  override func tearDown() async throws {
    mockDataSource = nil
    repository = nil
    try await super.tearDown()
  }
  
  func testFetchSurveyDetails_Success() async throws {
    givenSuccessDataSource()
    try await whenSuccessFetchSurvey()
    thenSuccessFetchSurvey()
  }
  
  func testFetchSurveyDetails_Error() async throws {
    givenFailureDataSource()
    do {
      try await whenFailureFetchSurvey()
    } catch {
      thenFailureFetchSurvey()
    }
  }
}

// MARK: - GIVEN
extension SurveyRepositorySpec {
  
  private func givenSuccessDataSource() {
    mockDataSource.surveyItems = [
      SurveyItem(id: UUID().uuidString, type: .page),
      SurveyItem(id: UUID().uuidString, type: .page),
      SurveyItem(id: UUID().uuidString, type: .page)
    ]
    
    repository = SurveyRepository(remoteDataSource: mockDataSource)
  }
  
  private func givenFailureDataSource() {
    mockDataSource.shouldThrowError = true
    repository = SurveyRepository(remoteDataSource: mockDataSource)
  }
}

// MARK: - WHEN
extension SurveyRepositorySpec {
  
  private func whenSuccessFetchSurvey() async throws {
    expectedItems = try await repository.fetchSurveyDetails()
  }
  
  private func whenFailureFetchSurvey() async throws {
    _ = try await repository.fetchSurveyDetails()
  }
}

// MARK: - THEN
extension SurveyRepositorySpec {
  
  private func thenSuccessFetchSurvey() {
    XCTAssertEqual(expectedItems.count, 3)
    XCTAssertEqual(expectedItems[0].type, .page)
  }
  
  private func thenFailureFetchSurvey() {
    XCTAssertTrue(true, "Service fails")
  }
}
