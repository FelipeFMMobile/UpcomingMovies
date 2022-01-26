//
//  ListMoviesUI.swift
//  UpComingMovies
//
//  Created by Felipe Menezes on 24/01/22.
//  Copyright © 2022 FMMobile. All rights reserved.
//

import SwiftUI

protocol ListMoviesUIDelegate: AnyObject {
    func didTapDetail(movie: MoviesModelCodable)
}

struct ListMoviesUI: View {
    @ObservedObject var viewModel: UpComingListViewModel
    weak var delegate: ListMoviesUIDelegate?

    var body: some View {
        List(viewModel.movies, id: \.idM) { movie in
            if let genre = viewModel.genreForMovie(movie: movie) {
                MovieRowUI(rowModel: ListMoviesCellModel(genre: genre,
                                                         movie: movie))
                    .gesture(TapGesture()
                                .onEnded({ _ in
                        viewModel.instantiateDetailSegue(movie: movie)
                    }))
            }
        }
    }
}

struct ListMoviesUI_Previews: PreviewProvider {
    static var previews: some View {
        ListMoviesUI(viewModel: PreviewModelData.viewModel)
    }
}
