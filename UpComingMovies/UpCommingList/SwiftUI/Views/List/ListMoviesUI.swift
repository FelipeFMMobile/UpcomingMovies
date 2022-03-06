//
//  ListMoviesUI.swift
//  UpComingMovies
//
//  Created by Felipe Menezes on 24/01/22.
//  Copyright © 2022 FMMobile. All rights reserved.
//

import SwiftUI
import SVProgressHUD

@available(iOS 14.0, *)
struct ListMoviesUI: View, UIViewControllerUtils {
    @StateObject var viewModel: UpComingListViewModel = UpComingListViewModel()
    @State private var isLast = false
    @State private var isFirstLoading = true
    var body: some View {
        NavigationView {
            VStack {
                List(viewModel.movies, id: \.idM) { movie in
                    NavigationLink {
                        DetailMovieUI(viewModel: $viewModel.detailViewModel)
                            .onAppear {
                                loadDetail(movie)
                            }.environmentObject(viewModel.envData)
                    } label: {
                        if let genre = viewModel.genreForMovie(movie: movie) {
                            let rowModel = ListMoviesCellModel(genre: genre, movie: movie)
                            MovieRowUI(rowModel: rowModel)
                                .onAppear {
                                    isLast = viewModel.movies.last == movie
                                    if isLast { loadMore() }
                                }.environmentObject(viewModel.envData)
                        }
                    }
                }.listStyle(.plain)
                if isLast {
                    ProgressView()
                }
            }.onAppear {
                if isFirstLoading {
                    startLoad()
                    isFirstLoading = false
                }
            }.navigationTitle(viewModel.title)
        }
    }
}

@available(iOS 14.0, *)
extension ListMoviesUI: LoaderHostingState {
    func startLoad() {
        loadGenres()
    }
    
    func titleForView() -> String? {
        return viewModel.title
    }
    
    private func loadGenres() {
        SVProgressHUD.show()
        viewModel.resetPage()
        viewModel.getGenres { result in
            switch result {
            case .success:
                self.loadMovies()
            case .failure(let error):
                self.displayError(error)
            }
        }
    }
    
    private func loadMovies() {
        viewModel.getUpCommingMovies { result in
            SVProgressHUD.dismiss()
            switch result {
            case .success:
                break
            case .failure(let error):
                self.displayError(error)
            }
        }
    }
    
    private func refresh() {
        loadGenres()
    }
    
    // MARK: LoadDetail
    
    private func loadDetail(_ movie: MoviesModelCodable) {
        SVProgressHUD.show()
        viewModel.getMovieInfo(movie: movie) { result in
            SVProgressHUD.dismiss()
            switch result {
            case .success:
                break
            case .failure(let error):
                self.displayError(error)
            }
        }
    }
    
    // MARK: Scrolling Load
    private func loadMore() {
        viewModel.forwardPage()
        loadMovies()
    }
    
}
@available(iOS 14.0, *)
struct ListMoviesUI_Previews: PreviewProvider {
    static var previews: some View {
        ListMoviesUI(viewModel: PreviewData.viewModel)
    }
}
