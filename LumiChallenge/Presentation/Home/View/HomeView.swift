import SwiftUI
import SwiftData

struct HomeView: View {
  @Environment(\.modelContext) private var modelContext
  @StateObject private var viewModel = HomeViewModel()
  @State private var selectedImage: SurveyImageItem?
  
  var body: some View {
    NavigationStack {
      Group {
        if viewModel.isLoading {
          ProgressView()
        } else if let error = viewModel.serviceError {
          ErrorView(error: error)
        } else {
          List(viewModel.items, children: \.items) { item in
            SurveyItemView(item: item)
              .onTapGesture {
                if case .image = item.type {
                  selectedImage = SurveyImageItem(
                    title: item.title ?? "",
                    imageUrl: item.src ?? ""
                  )
                }
              }
          }
          .listStyle(.insetGrouped)
        }
      }
      .navigationTitle("Survey")
      .toolbar {
        Button(action: {
          Task {
            await viewModel.fetchSurveyDetails()
          }
        }) {
          Image(systemName: "arrow.clockwise")
        }
      }
      .sheet(item: $selectedImage) { imageItem in
        ImageDetailView(item: imageItem)
      }
    }
  }
  
  // MARK: -  Custom init for snapshot testing
  init(viewModel: HomeViewModel) {
    _viewModel = StateObject(wrappedValue: viewModel)
  }
  
  init() {
    _viewModel = StateObject(wrappedValue: HomeViewModel())
  }
}

#Preview {
  HomeView()
    .modelContainer(for: Item.self, inMemory: true)
}
