//
//  UpComingListTableViewController.swift
//  UpComingMovies
//
//  Created by Felipe Menezes on 30/03/2018.
//  Copyright © 2018 FMMobile. All rights reserved.
//

import UIKit
import SVProgressHUD
import SwiftUI

class ListMoviesHostingController: UIHostingController<ListMoviesUI> {
    
    public init() {
        var uiView = ListMoviesUI(viewModel: self.viewModel)
        super.init(rootView: uiView)
        uiView.delegate = self
    }
    
    @MainActor @objc required dynamic init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
//
//    lazy var sUIView: ListMoviesUI = {
//        ListMoviesUI(viewModel: self.viewModel)
//    }()
//
//    lazy var contentView: UIHostingController = {
//        UIHostingController(rootView: sUIView)
//    }()
    
    let viewModel = UpComingListViewModel()

    override func viewDidLoad() {
        super.viewDidLoad()
//        addChild(contentView)
//        view.addSubview(contentView.view)
 //       setupConstraints()
        start()
    }
    
    fileprivate func setupConstraints() {
//        contentView.view.translatesAutoresizingMaskIntoConstraints = false
//        contentView.view.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
//        contentView.view.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
//        contentView.view?.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
//        contentView.view?.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
    }
    
    func start() {
        SVProgressHUD.show()
        viewModel.resetPage()
        
        viewModel.getGenres { [weak self] result in
            switch result {
            case .success:
                self?.loadingContent()
            case .failure(let error):
                self?.displayError(error)
            }
        }
    }
    
    func loadingContent() {
        viewModel.getUpCommingMovies { [weak self] result in
            guard let self = self else { return }
            SVProgressHUD.dismiss()
            switch result {
            case .success:
                break
            case .failure(let error):
                self.displayError(error)
            }
        }
    }
    
    @objc func refresh() {
        start()
    }

    public func instantiateDetailSegue(movie: MoviesModelCodable) {
        SVProgressHUD.show()
        viewModel.getMovieInfo(movie: movie, complete: { [weak self] result in
            SVProgressHUD.dismiss()
            switch result {
            case .success:
                if let movieInfo = self?.viewModel.detailMovie {
                    self?.viewModel.coordinatorDelegate?.gotoFlow("detailMovie", model: movieInfo)
                }
            case .failure(let error):
                self?.displayError(error)
            }
        })
    }
}

extension ListMoviesHostingController: ListMoviesUIDelegate {
    func genreForMovie(movie: MoviesModelCodable) -> GenreModelCodable? {
        viewModel.genreForMovie(movie: movie)
    }

    func didTapDetail(movie: MoviesModelCodable) {
        instantiateDetailSegue(movie: movie)
    }
}
