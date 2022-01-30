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
    @ObservedObject var viewModel: UpComingListViewModel = UpComingListViewModel()
    @State private var isLast = false
    var body: some View {
        VStack {
            List(viewModel.movies, id: \.idM) { movie in
                if let genre = viewModel.genreForMovie(movie: movie) {
                    MovieRowUI(rowModel: ListMoviesCellModel(genre: genre,
                                                             movie: movie))
                        .gesture(TapGesture()
                                    .onEnded({ _ in
                            viewModel.instantiateDetailSegue(movie: movie) { result in
                                switch result {
                                case .success:
                                    break
                                case .failure:
                                    break
                                }
                                SVProgressHUD.dismiss()
                            }
                        }))
                        .onAppear {
                            isLast = viewModel.movies.last == movie
                            if isLast { loadMore() }
                        }
                }
            }.listStyle(.plain)
//                .refreshable {
//                    print("Do your refresh work here")
//                }
            if isLast {
                if #available(iOS 14.0, *) {
                    ProgressView()
                } else {
                    // Fallback on earlier versions
                }
            }
        }
    }
    
    private func loadMore() {
        viewModel.forwardPage()
        loadingContent()
    }
    
}

extension ListMoviesUI: LoaderHostingState {
    func startDidLoad() {
        SVProgressHUD.show()
        viewModel.resetPage()
        viewModel.getGenres { result in
            switch result {
            case .success:
                self.loadingContent()
            case .failure(let error):
                self.displayError(error)
            }
        }
    }
    
    func loadingContent() {
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
    
    func refresh() {
        startDidLoad()
    }
}

struct ListMoviesUI_Previews: PreviewProvider {
    static var previews: some View {
        ListMoviesUI(viewModel: PreviewData.viewModel)
    }
}
