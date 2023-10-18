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
    @StateObject var rowModel: MovieRowUIViewModel
    @EnvironmentObject private var envData: EnviromentData
    @State private var isSet: Bool = false
    
    var body: some View {
        HStack(alignment: .top,
               spacing: 12.0) {
            ImageLoaderView(url: rowModel.posterPath)
                .frame(height: 150)
            VStack(alignment: .leading, spacing: 4.0) {
                HStack(alignment: .top) {
                    Text(rowModel.title)
                        .font(.title2)
                        .lineLimit(2)
                }
                Text(rowModel.genreTitle)
                    .font(.caption)
                Text(rowModel.sinopses)
                    .font(.caption2)
                    .padding(.all, 4.0)
                    .lineLimit(4)
                Spacer()
                HStack {
                    Spacer()
                    Text(rowModel.releaseDate)
                        .font(.caption2)
                    StarButton(isSet: $isSet)
                        .onAppear {
                            isSet = envData.favoritesMovies[rowModel.movieID] ?? false
                        }
                }
            }
        }.padding(8)
    }
}

struct MovieRowUI_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            MovieRowUI(rowModel: PreviewEnviroment.cellModel).environmentObject(EnviromentData())
            MovieRowUI(rowModel: PreviewEnviroment.cellModel2).environmentObject(EnviromentData())
        }.previewLayout(.fixed(width: 345, height: 200))
    }
}
