//
//  UpComingListTableViewController.swift
//  UpComingMovies
//
//  Created by Felipe Menezes on 30/03/2018.
//  Copyright © 2018 FMMobile. All rights reserved.
//

import UIKit
import SVProgressHUD

class UpComingListTableViewController: UITableViewController, UIViewCoordinator {
    weak var coordinatorDelegate: AppCoordinatorDelegate?
    
    let viewModel = UpComingListViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        refreshControl?.addTarget(self, action: #selector(self.refresh), for: UIControl.Event.valueChanged)
        
        title = viewModel.title
        
        // Handle Pagination
        self.tableView.addInfiniteScroll { [weak self] (tableView) -> Void in
            self?.viewModel.forwardPage()
            self?.loadingContent()
            self?.tableView.finishInfiniteScroll()
        }
        
        tableView.register(UINib(nibName: ListMoviesTableViewCell.nib, bundle: nil),
                           forCellReuseIdentifier: ListMoviesTableViewCell.identifier)
        
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 44
        start()
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
            DispatchQueue.main.async { self?.refreshControl?.endRefreshing() }
        }
    }
    
    func loadingContent() {
        viewModel.getUpCommingMovies { [weak self] result in
            SVProgressHUD.dismiss()
            switch result {
            case .success:
                DispatchQueue.main.async { self?.tableView.reloadData() }
            case .failure(let error):
                self?.displayError(error)
            }
        }
    }
    
    @objc func refresh() {
        start()
    }
    
    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return self.viewModel.numberOfSections()
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.viewModel.numRowsSection(section: section)
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: ListMoviesTableViewCell.identifier)
            as? ListMoviesTableViewCell {
            if let movie = viewModel.valueForCellPosition(indexPath: indexPath) {
                let genres = viewModel.genreList?.genresForMovie(movie: movie)
                if let genre = genres?.first {
                    let cellModel = ListMoviesCellModel(genre: genre, movie: movie)
                    cell.drawCell(cellModel: cellModel)
                }
            }
            return cell
        }
        return UITableViewCell()
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        if let movie = viewModel.valueForCellPosition(indexPath: indexPath) {
            instantiateDetailSegue(movie: movie)
        }
    }
    
    public func instantiateDetailSegue(movie: MoviesModelCodable) {
        SVProgressHUD.show()
        viewModel.getMovieInfo(movie: movie, complete: { [weak self] result in
            SVProgressHUD.dismiss()
            switch result {
            case .success:
                if let movieInfo = self?.viewModel.detailMovie {
                    self?.coordinatorDelegate?.gotoFlow("detailMovie", model: movieInfo)
                }
            case .failure(let error):
                self?.displayError(error)
            }
        })
    }
}
