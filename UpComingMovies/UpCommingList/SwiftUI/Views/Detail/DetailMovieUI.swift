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
    @State private var firstTime = !PreviewEnviroment.isPreviewing
    var favoriteIndex: Int {
        envData.favoritesMovies.firstIndex(where: {
            $0.idM == viewModel.movie?.idM
        }) ?? -1
    }

    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            HStack(alignment: .top) {
                if let poster = viewModel.posterPath {
                    ImageLoaderView(url: poster)
                        .frame(height: 200)
                }
                Text(viewModel.overview ?? "")
                    .font(.system(size: 14))
                    .lineLimit(12)
                    .foregroundColor(.gray)
                    .padding(8)
            }
            HStack {
                Text(viewModel.title ?? "")
                    .font(.system(size: 22))
                    .lineLimit(3)
                if favoriteIndex >= 0 {
                    StarButton(isSet: $envData.favoritesMovies[favoriteIndex].isFavorite)
                }
            }
            Text(viewModel.releaseDate ?? "")
                .font(.system(size: 14))
                .lineLimit(1)
            HStack {
                Spacer()
                Text(viewModel.genresString ?? "")
                    .font(.system(size: 14))
                    .lineLimit(1)
            }
        }.padding(16.0)
        .opacity(firstTime ? 0 : 1)
        Spacer()
        .onAppear {
            if firstTime {
                Task {
                    try? await loadDetail()
                }
            }
        }
        .navigationTitle(viewModel.title ?? "")
        .navigationBarTitleDisplayMode(.inline)
    }
}

@available(iOS 15.0, *)
struct DetailMovieUI_Previews: PreviewProvider {
    static var previews: some View {
        DetailMovieUI(viewModel: PreviewEnviroment.detailViewModel)
            .environmentObject(EnviromentData())
    }
}

@available(iOS 15.0, *)
extension DetailMovieUI: LoaderHostingState {
    func titleForView() -> String? {
        return viewModel.title
    }

    // MARK: LoadDetail
    private func loadDetail() async throws {
        SVProgressHUD.show()
        try? await viewModel.detail()
        await SVProgressHUD.dismiss()
        firstTime = false
    }
}
