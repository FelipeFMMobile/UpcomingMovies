//
//  EnviromentFavorites.swift
//  UpComingMovies
//
//  Created by Felipe Menezes on 01/02/22.
//  Copyright © 2022 FMMobile. All rights reserved.
//

import Combine

class EnviromentData: ObservableObject {
    var favoritesMovies: [Int: Bool] = [:]

    func setFavorite(movieId: Int, activate: Bool) {
        favoritesMovies[movieId] = activate
    }
}
