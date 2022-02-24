//
//  UpComingListTableViewController.swift
//  UpComingMovies
//
//  Created by Felipe Menezes on 30/03/2018.
//  Copyright © 2018 FMMobile. All rights reserved.
//

import UIKit
import SVProgressHUD

class UpComingListTableViewController: UIViewController, UIViewControllerUtils {
    let viewModel = UpComingListViewModel()

    // here just for sample purpose of SwiftUI
    var coordinator: AnyObject?
    
    lazy var listView: UpComingListTableView = {
        return UpComingListTableView()
    }()
    
    override func loadView() {
        self.view = listView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        refreshControl?.addTarget(self, action: #selector(self.refresh), for: UIControl.Event.valueChanged)
        
        title = viewModel.title
        
        // Handle Pagination
        self.listView.tableView.addInfiniteScroll { [weak self] (tableView) -> Void in
            self?.viewModel.forwardPage()
            self?.loadingContent()
            self?.listView.tableView.finishInfiniteScroll()
        }
        listView.tableView.delegate = self
        listView.tableView.dataSource = self
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
            // DispatchQueue.main.async { self?.refreshControl?.endRefreshing() }
        }
    }
    
    func loadingContent() {
        viewModel.getUpCommingMovies { [weak self] result in
            SVProgressHUD.dismiss()
            switch result {
            case .success:
                DispatchQueue.main.async { self?.listView.tableView.reloadData() }
            case .failure(let error):
                self?.displayError(error)
            }
        }
    }
    
    @objc func refresh() {
        start()
    }
    
    // MARK: - Table view data source
    
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
    
    @IBAction func callSwiftUIVersion(_ sender: Any) {
        if #available(iOS 14.0, *) {
            guard let navController = self.navigationController else { return }
            var coordinator = UpCommingCoordinatorHosting(nav: navController)
            if let controller = try? coordinator.start(.none) {
                self.present(controller, animated: true, completion: nil)
            }
            self.coordinator = coordinator
        }
    }
}

extension UpComingListTableViewController: UITableViewDataSource, UITableViewDelegate {
    func numberOfSections(in tableView: UITableView) -> Int {
        return self.viewModel.numberOfSections()
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.viewModel.numRowsSection(section: section)
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: ListMoviesTableViewCell.identifier)
            as? ListMoviesTableViewCell {
            if let movie = viewModel.valueForCellPosition(indexPath: indexPath) {
                if let genre = viewModel.genreForMovie(movie: movie) {
                    let cellModel = ListMoviesCellModel(genre: genre, movie: movie)
                    cell.drawCell(cellModel: cellModel)
                }
            }
            return cell
        }
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        if let movie = viewModel.valueForCellPosition(indexPath: indexPath) {
            instantiateDetailSegue(movie: movie)
        }
    }
}
