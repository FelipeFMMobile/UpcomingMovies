//
//  ImageLoaderView.swift
//  UpComingMovies
//
//  Created by Felipe Menezes on 30/01/22.
//  Copyright © 2022 FMMobile. All rights reserved.
//

import SwiftUI
import Kingfisher

struct ImageLoaderView: View {
    let url: URL
    var body: some View {
        KFImage.url(url)
            .fade(duration: 0.25)
            .placeholder {
                // Placeholder while downloading.
                Image("cover")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
            }
            .onProgress { _, _ in  }
            .onSuccess { _ in  }
            .onFailure { _ in }
            .resizable()
            .aspectRatio(contentMode: .fit)
            .shadow(color: .gray,
                    radius: 2.0, x: 4.0, y: 4.0)
        
    }
}

struct ImageLoaderView_Previews: PreviewProvider {
    static var previews: some SwiftUI.View {
        Group {
            ImageLoaderView(url:
                                URL(string: "https://image.tmdb.org/t/p/w185//pU3bnutJU91u3b4IeRPQTOP8jhV.jpg")!
            )
        }.previewLayout(.fixed(width: 200, height: 150))
    }
}
