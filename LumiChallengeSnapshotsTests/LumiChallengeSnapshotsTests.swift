import SnapshotTesting
import XCTest
import SwiftUI
@testable import LumiChallenge

@MainActor
final class LumiChallengeSnapshotsTests: XCTestCase {
  
  func test_home_view() {
    let mockViewModel = HomeViewModel()
    mockViewModel.items = SurveyItem.mockSurvey
    
    let view = HomeView(viewModel: mockViewModel)
    let viewController = UIHostingController(rootView: view)
    
    assertSnapshot(
      of: viewController,
      as: .image(on: .iPhone13),
      record: false,
      testName: "HomeView"
    )
  }
}
