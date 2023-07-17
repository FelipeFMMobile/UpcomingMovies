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
                            .redacted(reason: isLast ? .placeholder : [])
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
