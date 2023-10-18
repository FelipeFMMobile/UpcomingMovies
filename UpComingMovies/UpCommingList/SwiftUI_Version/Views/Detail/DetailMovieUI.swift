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
    @State private var isLoading = true
    @State private var isSet: Bool = false
    
    init(viewModel: DetailUIViewModel) {
        _viewModel = StateObject(wrappedValue: viewModel)
    }

    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
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
                        envData.setFavorite(movieId: viewModel.movieId, activate: newValue)
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
        }.padding(16.0)
        .redacted(reason: isLoading ? .placeholder : [])
        Spacer()
        .task(priority: .background) {
            try? await viewModel.detail()
            isLoading = false
            isSet = envData.favoritesMovies[viewModel.movieId] ?? false
        }
        .navigationTitle(viewModel.title)
        .navigationBarTitleDisplayMode(.inline)
    }
}

extension DetailMovieUI: LoaderHostingState {
    func titleForView() -> String? {
        return viewModel.title
    }
}

struct DetailMovieUI_Previews: PreviewProvider {
    static var previews: some View {
        DetailMovieUI(viewModel: DetailUIViewModel(movie: PreviewEnviroment.movies.results!.first!)
        ).environmentObject(EnviromentData())
    }
}
