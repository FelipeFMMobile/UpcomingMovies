//
//  EnviromentFavorites.swift
//  UpComingMovies
//
//  Created by Felipe Menezes on 01/02/22.
//  Copyright © 2022 FMMobile. All rights reserved.
//

import Combine

class EnviromentData: ObservableObject {
    @Published var favoritesMovies: [MovieMark] = []
    struct MovieMark {
        var idM: Int
        var isFavorite: Bool
    }
}
