//
//  DetailMovieUI.swift
//  UpComingMovies
//
//  Created by Felipe Menezes on 25/01/22.
//  Copyright © 2022 FMMobile. All rights reserved.
//

import SwiftUI
import SVProgressHUD

@available(iOS 15.0, *)
struct DetailMovieUI: View {
    @StateObject var viewModel: DetailUIViewModel
    @EnvironmentObject private var envData: EnviromentData
    @State private var isSet: Bool = false
    
    init(movie: MoviesModelCodable) {
        _viewModel = StateObject(wrappedValue: DetailUIViewModel(movie: movie))
    }

    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            // switch use structural identity in SwiftUI
            switch viewModel.state {
            case .loading, .success:
                detailView()
            case .error:
                Text("Some erro appears")
            case .idle:
                Text("Some erro appears")
            }
        }.padding(16.0)
            .redacted(reason: viewModel.state == .loading ? .placeholder : [])
        Spacer()
        .task {
            try? await viewModel.detail()
            isSet = envData.favoritesMovies[viewModel.movieId] ?? false
        }
        .navigationTitle(viewModel.title)
        .navigationBarTitleDisplayMode(.inline)
    }

    @ViewBuilder
    func detailView() -> some View {
        HStack(alignment: .top) {
            ImageLoaderView(url: viewModel.posterPath)
                .frame(height: 200)
            Text(viewModel.overview)
                .font(.system(size: 14))
                .lineLimit(12)
                .foregroundColor(.gray)
                .padding(8)
        }
        HStack {
            Text(viewModel.title)
                .font(.system(size: 22))
                .lineLimit(3)
            StarButton(isSet: $isSet)
                .onChange(of: isSet) { newValue in
                    envData.setFavorite(movieId: viewModel.movieId,
                                        activate: newValue)
                }
        }
        Text(viewModel.releaseDate)
            .font(.system(size: 14))
            .lineLimit(1)
        HStack {
            Spacer()
            Text(viewModel.genresString)
                .font(.system(size: 14))
                .lineLimit(1)
        }
    }
}

struct DetailMovieUI_Previews: PreviewProvider {
    static var previews: some View {
        DetailMovieUI(movie: PreviewEnviroment.movies.results!.first!
        ).environmentObject(EnviromentData())
    }
}
