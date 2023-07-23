//
//  ListMoviesUI.swift
//  UpComingMovies
//
//  Created by Felipe Menezes on 24/01/22.
//  Copyright © 2022 FMMobile. All rights reserved.
//

import SwiftUI
import SVProgressHUD

struct ListMoviesUI: View, UIViewControllerUtils {
    @StateObject var viewModel = ListUIViewModel()
    @State private var isLast = false
    @State private var isLoading = true
    var body: some View {
        NavigationView {
            VStack {
                List(isLoading ? PreviewEnviroment.movies.results ?? [] : viewModel.movies,
                     id: \.idM) { movie in
                    NavigationLink {
                        DetailMovieUI(viewModel: DetailUIViewModel(movie: movie))
                            .environmentObject(viewModel.envData)
                    } label: {
                        let rowModel = MovieRowUIViewModel(movie: movie)
                        MovieRowUI(rowModel: rowModel)
                            .environmentObject(viewModel.envData)
                            .redacted(reason: isLoading ? .placeholder : [])
                    }.task {
                        isLast = viewModel.movies.last == movie
                        if isLast {
                            try? await loadMore()
                        }
                    }                    
                }.listStyle(.plain)
            }.navigationTitle(viewModel.title)
            .task {
                try? await loadMovies()
                isLoading = false
            }
            .refreshable {
                try? await refresh()
            }
        }
    }
}

extension ListMoviesUI: LoaderHostingState {
    func titleForView() -> String? {
        return viewModel.title
    }

    private func loadMovies() async throws {
        try await viewModel.moviesList()
    }

    private func refresh() async throws {
        viewModel.resetPage()
        if !isLast { SVProgressHUD.show() }
        try await loadMovies()
        await SVProgressHUD.dismiss()
    }

    // MARK: Scrolling Load
    private func loadMore() async throws {
         viewModel.forwardPage()
         try await loadMovies()
    }
}

struct ListMoviesUI_Previews: PreviewProvider {
    static var previews: some View {
        ListMoviesUI(viewModel: PreviewEnviroment.listViewModel)
    }
}
