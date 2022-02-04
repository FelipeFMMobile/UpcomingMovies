//
//  MovieRowUI.swift
//  UpComingMovies
//
//  Created by Felipe Menezes on 24/01/22.
//  Copyright © 2022 FMMobile. All rights reserved.
//

import SwiftUI
import Kingfisher

struct MovieRowUI: View {
    var rowModel: ListMoviesCellModel
    var body: some View {
        HStack(alignment: .top,
               spacing: 12.0) {
            ImageLoaderView(url: rowModel.posterPath)
                .frame(height: 150)
            VStack(alignment: .leading, spacing: 4.0) {
                HStack(alignment: .top) {
                    Text(rowModel.title)
                        .font(.system(size: 18))
                        .lineLimit(2)
                }
                Text(rowModel.genreTitle)
                    .font(.system(size: 12))
                Text(rowModel.sinopses)
                    .font(.system(size: 12))
                    .frame(width: 200)
                    .fixedSize()
                    .lineLimit(3)
                Spacer()
                HStack {
                    Spacer()
                    Text(rowModel.releaseDate)
                        .font(.system(size: 12))
                }
            }
        }.frame(height: 150)
            .padding(8)
    }
}

struct MovieRowUI_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            MovieRowUI(rowModel: PreviewData.cellModel)
            MovieRowUI(rowModel: PreviewData.cellModel2)
        }.previewLayout(.fixed(width: 300, height: 200))
    }
}
