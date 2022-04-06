//
//  ViewCodeProtocol.swift
//  UpComingMovies
//
//  Created by Felipe Menezes on 23/02/22.
//  Copyright © 2022 FMMobile. All rights reserved.
//

protocol ViewCodeProtocol {
    func setup()
    func setupViews()
    func setupConstraints()
    func configureViews()
}

extension ViewCodeProtocol {
    func setup() {
        setupViews()
        setupConstraints()
        configureViews()
    }
    func configureViews() {}
}
