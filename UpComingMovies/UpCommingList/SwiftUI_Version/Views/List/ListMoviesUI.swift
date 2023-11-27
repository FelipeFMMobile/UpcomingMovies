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
    var body: some View {
        NavigationView {
            VStack {
                // switch use structural identity in SwiftUI
                switch viewModel.state {
                case .loading:
                    listLoadingView()
                case .success:
                    listView()
                case .error:
                    Text("Some erro appears")
                case .idle:
                    Text("Some erro appears")
                }
            }.navigationTitle(viewModel.title)
                .task {
                try? await loadMovies()
            }
            .refreshable {
                try? await refresh()
            }
        }
    }

    @ViewBuilder
    private func listView() -> some View {
        List(viewModel.movies,
             id: \.idM) { movie in
            NavigationLink {
                DetailMovieUI(movie: movie)
                    .environmentObject(viewModel.envData)
            } label: {
                rowView(movie: movie)
            }.task(priority: .background) {
                if viewModel.movies.last == movie {
                    try? await viewModel.loadMore()
                }
            }
        }.listStyle(.plain)
    }
    
    // list loading view
    @ViewBuilder
    private func listLoadingView() -> some View {
        List(PreviewEnviroment.movies.results ?? [], id: \.idM) { movie in
            rowView(movie: movie)
                .redacted(reason: .placeholder)
        }.listStyle(.plain)
    }

    // row View
    @ViewBuilder
    private func rowView(movie: MoviesModelCodable) -> some View {
        MovieRowUI(movie: movie)
            .environmentObject(viewModel.envData)
    }
}

extension ListMoviesUI {

    private func loadMovies() async throws {
        if viewModel.state == .idle {
            try await viewModel.moviesList(true)
        }
    }

    private func refresh() async throws {
        viewModel.resetPage()
        try await loadMovies()
    }
}

struct ListMoviesUI_Previews: PreviewProvider {
    static var previews: some View {
        ListMoviesUI(viewModel: 
                        ListUIViewModel(movies: PreviewEnviroment.movies.results!)
        )
    }
}
