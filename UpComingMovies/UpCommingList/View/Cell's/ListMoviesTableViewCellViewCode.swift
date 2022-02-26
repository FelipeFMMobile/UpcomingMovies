//
//  ListMoviesTableViewCell.swift
//  UpComingMovies
//
//  Created by Felipe Menezes on 01/04/2018.
//  Copyright © 2018 FMMobile. All rights reserved.
//

import UIKit
import Kingfisher
import SwiftUI

class ListMoviesTableViewCellViewCode: UITableViewCell, ViewCodeProtocol {
    public static var identifier = "ListMovieCell"
    public static var nib = "ListMoviesCell"

    lazy var contentStack: UIStackView = {
        let stack = UIStackView(frame: .zero)
        stack.alignment = . center
        stack.axis = .horizontal
        stack.spacing = 16
        stack.distribution = .fillProportionally
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()

    lazy var verticalStack: UIStackView = {
        let stack = UIStackView(frame: .zero)
        stack.alignment = .top
        stack.axis = .vertical
        stack.spacing = 4
        stack.distribution = .fill
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()

    lazy var posterImageView: UIImageView = {
        let view = UIImageView(frame: .zero)
        view.contentMode = .scaleAspectFit
        view.image = nil
        view.layer.shadowOffset = CGSize(width: 2.0, height: 2.0)
        view.layer.shadowRadius = 1.0
        view.layer.shadowColor = UIColor.lightGray.cgColor
        view.layer.shadowOpacity = 1.0
        return view
    }()

    lazy var titleLabel: UILabel = {
        let view = UILabel(frame: .zero)
        view.translatesAutoresizingMaskIntoConstraints = false
        view.font = .systemFont(ofSize: 18.0, weight: .semibold)
        view.textColor = .darkGray
        view.numberOfLines = 0
        return view
    }()

    lazy var genreLabel: UILabel = {
        let view = UILabel(frame: .zero)
        view.translatesAutoresizingMaskIntoConstraints = false
        view.font = .systemFont(ofSize: 12.0, weight: .regular)
        view.textColor = .gray
        view.numberOfLines = 0
        return view
    }()

    lazy var previewLabel: UILabel = {
        let view = UILabel(frame: .zero)
        view.translatesAutoresizingMaskIntoConstraints = false
        view.font = .systemFont(ofSize: 12.0, weight: .regular)
        view.textColor = .gray
        view.numberOfLines = 4
        view.textAlignment = .justified
        return view
    }()

    lazy var releaseLabel: UILabel = {
        let view = UILabel(frame: .zero)
        view.translatesAutoresizingMaskIntoConstraints = false
        view.font = .systemFont(ofSize: 12.0, weight: .semibold)
        view.textColor = .gray
        view.numberOfLines = 0
        view.textAlignment = .right
        return view
    }()

    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setup()
        
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        titleLabel.text = nil
        genreLabel.text = nil
        releaseLabel.text = nil
        posterImageView.image = nil
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }

    func setupViews() {
        self.contentView.addSubview(contentStack)
        contentStack.addArrangedSubview(posterImageView)
        contentStack.addArrangedSubview(verticalStack)
        verticalStack.addArrangedSubview(titleLabel)
        verticalStack.addArrangedSubview(genreLabel)
        verticalStack.addArrangedSubview(previewLabel)
        verticalStack.addArrangedSubview(releaseLabel)
    }
    
    func setupConstraints() {
        let constraints = [
            contentStack.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            contentStack.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            contentStack.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 16),
            contentStack.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -16),
            verticalStack.topAnchor.constraint(equalTo: contentStack.topAnchor),
            verticalStack.bottomAnchor.constraint(equalTo: contentStack.bottomAnchor),
            releaseLabel.trailingAnchor.constraint(equalTo: verticalStack.trailingAnchor),
            posterImageView.heightAnchor.constraint(equalToConstant: 120.0),
            posterImageView.widthAnchor.constraint(equalToConstant: 80.0)
        ]
        NSLayoutConstraint.activate(constraints)
    }

    func drawCell(cellModel: ListMoviesCellModel) {
        titleLabel.text = cellModel.title
        genreLabel.text = cellModel.genreTitle
        releaseLabel.text = cellModel.releaseDate
        previewLabel.text = cellModel.sinopses
        posterImageView.kf.setImage(with: cellModel.posterPath)
    }
}
