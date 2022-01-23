//
//  UpComingListRXTableViewController.swift
//  UpComingMovies
//
//  Created by FMMobile on 11/06/2019.
//  Copyright © 2019 FMMobile. All rights reserved.
//

import Foundation
import SVProgressHUD
import UIKit
import RxSwift
import RxCocoa

class UpComingListRXTableViewController: UIViewController, UITableViewDelegate {
    
    @IBOutlet weak var tableView: UITableView!
    
    var disposeBag = DisposeBag()
    
    var coordinator: UpCommingCoordinator?
    
    let viewModel = UpComingListViewModelRX()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = viewModel.title
        
        tableView.register(UINib(nibName: ListMoviesTableViewCell.nib, bundle: nil),
                           forCellReuseIdentifier: ListMoviesTableViewCell.identifier)
        
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 44
        
        viewModel.moviesSubject
            .bind(to: tableView.rx.items(cellIdentifier: ListMoviesTableViewCell.identifier,
                                         cellType: ListMoviesTableViewCell.self)) { (_, element, cell) in
                                            let genres = self.viewModel.genreList?.genresForMovie(movie: element)
                                            if let genre = genres?.first {
                                                let cellModel = ListMoviesCellModel(genre: genre, movie: element)
                                                cell.drawCell(cellModel: cellModel)
                                            }
        }
        .disposed(by: disposeBag)
        
        tableView.rx
            .modelSelected(MoviesModelCodable.self)
            .subscribe(onNext: { value in
                SVProgressHUD.show()
                self.viewModel.getMovieInfo(movie: value, complete: { [weak self] result in
                    SVProgressHUD.dismiss()
                    switch result {
                    case .success:
                        if let movieInfo = self?.viewModel.detailMovie {
                            _ = self?.coordinator?.gotoDetail(detailMovie: movieInfo)
                        }
                    case .failure(let error):
                        self?.displayError(error)
                    }
                })
            })
            .disposed(by: disposeBag)
        
        SVProgressHUD.show()
        viewModel.getGenres { [weak self] result in
            self?.viewModel.getUpCommingMovies { result in
                SVProgressHUD.dismiss()
                switch result {
                case .success:
                    break
                case .failure(let error):
                    self?.displayError(error)
                }
            }
        }
    }
}
