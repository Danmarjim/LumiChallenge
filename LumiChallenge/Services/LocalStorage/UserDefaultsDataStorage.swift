import Foundation

protocol SurveyLocalStorage {
  func saveSurveys(_ surveys: [SurveyItem]) async throws
  func loadSurveys() async throws -> [SurveyItem]
}

enum StorageError: Error {
  case encodingFailed(Error)
  case decodingFailed(Error)
  
  var localizedDescription: String {
    switch self {
    case .encodingFailed(let error):
      return "Store error: \(error.localizedDescription)"
      
    case .decodingFailed(let error):
      return "Load error: \(error.localizedDescription)"
    }
  }
}

class UserDefaultsDataStorage: SurveyLocalStorage {
  private let userDefaults: UserDefaults
  private let storageKey = "survey"
  
  init(userDefaults: UserDefaults = .standard) {
    self.userDefaults = userDefaults
  }
  
  func saveSurveys(_ surveys: [SurveyItem]) async throws {
    do {
      let data = try JSONEncoder().encode(surveys)
      userDefaults.set(data, forKey: storageKey)
    } catch {
      throw StorageError.encodingFailed(error)
    }
  }
  
  func loadSurveys() async throws -> [SurveyItem] {
    guard let data = userDefaults.data(forKey: storageKey) else {
      return []
    }
    
    do {
      return try JSONDecoder().decode([SurveyItem].self, from: data)
    } catch {
      throw StorageError.decodingFailed(error)
    }
  }
}
