//
//  ListMoviesUI.swift
//  UpComingMovies
//
//  Created by Felipe Menezes on 24/01/22.
//  Copyright © 2022 FMMobile. All rights reserved.
//

import SwiftUI
import SVProgressHUD

@available(iOS 15.0, *)
struct ListMoviesUI: View, UIViewControllerUtils {
    @StateObject var viewModel = ListUIViewModel()
    @State private var isLast = false
    @State private var firstTime = !PreviewEnviroment.isPreviewing
    var body: some View {
        NavigationView {
            VStack {
                List(viewModel.movies, id: \.idM) { movie in
                    NavigationLink {
                        DetailMovieUI(viewModel: DetailUIViewModel(movie: movie))
                            .environmentObject(viewModel.envData)
                    } label: {
                        let rowModel = MovieRowUIViewModel(movie: movie)
                        MovieRowUI(rowModel: rowModel)
                            .environmentObject(viewModel.envData)
                    } .onAppear {
                        isLast = viewModel.movies.last == movie
                        if isLast {
                            Task { try? await loadMore() }
                        }
                    }
                }.listStyle(.plain)
                if isLast {
                    ProgressView()
                }
            }.navigationTitle(viewModel.title)
            .onAppear {
                if firstTime {
                    Task { try? await loadMovies() }
                }
            }
            .refreshable {
                try? await refresh()
            }
        }
    }
}

@available(iOS 15.0, *)
extension ListMoviesUI: LoaderHostingState {    
    func titleForView() -> String? {
        return viewModel.title
    }

    private func loadMovies() async throws {
        SVProgressHUD.show()
        try await viewModel.moviesList()
        await SVProgressHUD.dismiss()
        firstTime = false
    }

    private func refresh() async throws {
        viewModel.resetPage()
        try await loadMovies()
    }

    // MARK: Scrolling Load
    private func loadMore() async throws {
         viewModel.forwardPage()
         try await loadMovies()
    }
}
@available(iOS 15.0, *)
struct ListMoviesUI_Previews: PreviewProvider {
    static var previews: some View {
        ListMoviesUI(viewModel: PreviewEnviroment.listViewModel)
    }
}
