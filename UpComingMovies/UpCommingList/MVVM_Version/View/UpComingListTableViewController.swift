//
//  UpComingListTableViewController.swift
//  UpComingMovies
//
//  Created by Felipe Menezes on 30/03/2018.
//  Copyright © 2018 FMMobile. All rights reserved.
//

import UIKit
import SVProgressHUD

final class UpComingListTableViewController: UIViewController, ViewCodeProtocol, UIViewControllerUtils {
    let viewModel = UpComingListViewModel()

    // here just for sample purpose of SwiftUI
    var coordinator: AnyObject?

    // MARK: ViewCode
    lazy var tableView: UITableView = {
        let view = UITableView(frame: .zero)
        view.translatesAutoresizingMaskIntoConstraints = false
        view.rowHeight = UITableView.automaticDimension
        view.estimatedRowHeight = 44
        view.backgroundColor = AppTheme.whiteColor
        return view
    }()

    lazy var refreshControl: UIRefreshControl = {
        let refresh = UIRefreshControl(frame: .zero)
        refresh.tintColor = AppTheme.blackColor
        return refresh
    }()

    func setupViews() {
        self.view.addSubview(tableView)
        tableView.refreshControl = refreshControl
        tableView.register(ListMoviesTableViewCellView.self,
                           forCellReuseIdentifier: ListMoviesTableViewCellView.identifier)
    }

    func setupConstraints() {
        let constraints = [
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -8),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 8),
            tableView.topAnchor.constraint(equalTo: view.topAnchor, constant: 0),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 0),
            tableView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            tableView.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ]
        NSLayoutConstraint.activate(constraints)
    }
    
    // MARK: LifeCycle
    override func loadView() {
        super.loadView()
        view.backgroundColor = AppTheme.whiteColor
        setup()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = viewModel.title
        setupTableView()
        start()
    }
    
    func setupTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        refreshControl.addTarget(self, action: #selector(self.refresh),
                                          for: UIControl.Event.valueChanged)
        tableView.estimatedRowHeight = 40.0
        tableView.rowHeight = UITableView.automaticDimension

        self.navigationItem.leftBarButtonItem = UIBarButtonItem(title: "SwiftUI",
                                                                style: .plain,
                                                                target: self,
                                                                action: #selector(self.callSwiftUIVersion(_:)))
    }

    private func loadMoreContent() {
        guard !SVProgressHUD.isVisible() else { return }
        self.viewModel.forwardPage()
        self.loadingContent()
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
            DispatchQueue.main.async { self?.refreshControl.endRefreshing() }
        }
    }
    
    func loadingContent() {
        SVProgressHUD.show()
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
    public func loadDetailInfo(movie: MoviesModelCodable) {
        SVProgressHUD.show()
        viewModel.getMovieInfo(movie: movie, complete: { [weak self] result in
            SVProgressHUD.dismiss()
            switch result {
            case .success:
                if let movieInfo = self?.viewModel.detailMovie {
                    self?.viewModel.coordinatorDelegate?.goToFlow("detailMovie", model: movieInfo)
                }
            case .failure(let error):
                self?.displayError(error)
            }
        })
    }
    
    @IBAction func callSwiftUIVersion(_ sender: Any) {
        if #available(iOS 15.0, *) {
            guard let navController = self.navigationController else { return }
            var coordinator = UpCommingCoordinatorHostingUI(nav: navController)
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
        if let cell = tableView.dequeueReusableCell(withIdentifier: ListMoviesTableViewCellView.identifier)
            as? ListMoviesTableViewCellView {
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
            loadDetailInfo(movie: movie)
        }
    }

    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        // Calculate the total number of rows in the table view
        let totalRows = tableView.numberOfRows(inSection: 0)
        
        // Calculate the last visible row on the screen
        let lastVisibleRow = tableView.indexPathsForVisibleRows?.last?.row ?? 0
        
        // Check if the last visible row is the last row of the table view
        if lastVisibleRow == indexPath.row {
            loadMoreContent()
        }
    }
}
