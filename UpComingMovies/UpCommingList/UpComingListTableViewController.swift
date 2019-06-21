//
//  UpComingListTableViewController.swift
//  UpComingMovies
//
//  Created by Felipe Menezes on 30/03/2018.
//  Copyright © 2018 FMMobile. All rights reserved.
//

import UIKit
#if !RX_NO_MODULE
  import RxSwift
  import RxCocoa
  import RxDataSources
#endif
import SVProgressHUD

struct SectionMovie {
  var header: String    
  var items: [MoviesModelMap]
}

extension SectionMovie: SectionModelType {
  typealias Item = MoviesModelMap
  
  init(original: SectionMovie, items: [MoviesModelMap]) {
    self = original
    self.items = items
  } 
}

class UpComingListTableViewController: UITableViewController {
  
  let viewModel = UpComingListViewModel()
  
  let disposeBag = DisposeBag()
  
  override func viewDidLoad() {
    super.viewDidLoad()
    refreshControl?.addTarget(self, action: #selector(self.refresh), for: UIControlEvents.valueChanged)
    
    title = "Upcoming Movies"
    
    //Handle Pagination
    self.tableView.addInfiniteScroll { [weak self] (tableView) -> Void in
      self?.viewModel.forwardPage()
      self?.loadingContent()
      self?.tableView.finishInfiniteScroll()
    }
    
    tableView.register(UINib(nibName: ListMoviesTableViewCell.nib, bundle: nil), 
                       forCellReuseIdentifier: ListMoviesTableViewCell.identifier)
    
    tableView.rowHeight = UITableViewAutomaticDimension
    tableView.estimatedRowHeight = 44
    start()
  }
  
  func start() {
    SVProgressHUD.show()
    viewModel.resetPage()
    
    setupRx()
    
    viewModel.getGenres { [weak self] in
      self?.loadingContent()
      self?.refreshControl?.endRefreshing()
    }
  }
  
  func setupRx() {
    //Observer for loading events
    let moviesRx = viewModel.movies.asObservable()
    moviesRx
      .observeOn(MainScheduler.instance)
      .subscribe(onNext: { [weak self] moviesArray in
        if moviesArray != nil && moviesArray?.count ?? 0 > 0 {
          self?.tableView.reloadData()
        }
        }, onError: { _ in}
      ).addDisposableTo(disposeBag)
  }
  
  func loadingContent() {
    viewModel.getUpCommingMovies {
      SVProgressHUD.dismiss()
    }
  }
  
  @objc func refresh() {
    start()
  }
  
  // MARK: - Table view data source
  
  override func numberOfSections(in tableView: UITableView) -> Int {
    return 1
  }
  
  override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return self.viewModel.numRowsSection(section: section)
  }
  
  override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    if let cell = tableView.dequeueReusableCell(withIdentifier: ListMoviesTableViewCell.identifier) 
      as? ListMoviesTableViewCell {
      if let movie = viewModel.movies.value?[indexPath.row] {
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
    if let movie = viewModel.movies.value?[indexPath.row] {
      instantiateDetailSegue(movie: movie)
    }
  }
  
  public func instantiateDetailSegue(movie: MoviesModelMap) {
    if let detailController = self.storyboard?.instantiateViewController (
      withIdentifier: DetailUpComingListTableViewController.DetailIdentifier)  
      as? DetailUpComingListTableViewController {
      SVProgressHUD.show()
      viewModel.getMovieInfo(movie: movie, complete: { [weak self] in
        SVProgressHUD.dismiss()
        if let movieInfo = self?.viewModel.detailMovie {
          let genres = self?.viewModel.genreList?.genresForMovie(movie: movie)
          detailController.viewModel = DetailUpCommingListViewModel(genres: genres, movie: movieInfo)
          self?.navigationController?.pushViewController(detailController, animated: true)
        }
      })
    }
  }
}
