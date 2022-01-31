//
//  DetailMovieUI.swift
//  UpComingMovies
//
//  Created by Felipe Menezes on 25/01/22.
//  Copyright © 2022 FMMobile. All rights reserved.
//

import SwiftUI

struct DetailMovieUI: View {
    @ObservedObject var viewModel: DetailUpCommingListViewModel
    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
                HStack(alignment: .top) {
                    ImageLoaderView(url: viewModel.posterPath)
                        .frame(height: 200)
                    Text(viewModel.overview ?? "")
                        .font(.system(size: 14))
                        .lineLimit(12)
                        .foregroundColor(.gray)
                        .padding(8)
                }
                Text(viewModel.title ?? "")
                    .font(.system(size: 22))
                    .lineLimit(3)
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
            Spacer()
        }
}

struct DetailMovieUI_Previews: PreviewProvider {
    static var previews: some View {
        DetailMovieUI(viewModel: PreviewData.detailViewModel)
    }
}

extension DetailMovieUI: LoaderHostingState {
    func startDidLoad() {
    }
}
