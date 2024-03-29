//
//  DetailUpComingListTableViewController.swift
//  UpComingMovies
//
//  Created by Felipe Menezes on 30/03/2018.
//  Copyright © 2018 FMMobile. All rights reserved.
//

import UIKit
import Kingfisher

class DetailUpComingListTableViewController: UITableViewController, UIViewControllerUtils {

    static public var DetailIdentifier = "DetailMovieView"
    
    var viewModel: DetailUpCommingListViewModel?
    
    @IBOutlet weak var posterImageView: UIImageView!
    @IBOutlet weak var overviewLabel: UILabel!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var releaseLabel: UILabel!
    @IBOutlet weak var genreLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.backgroundColor = AppTheme.whiteColor
        self.title = viewModel?.title
        overviewLabel.text = viewModel?.overview
        overviewLabel.textColor = AppTheme.darkGrayColor
        titleLabel.text = viewModel?.title
        releaseLabel.text = viewModel?.releaseDate
        genreLabel.text = viewModel?.genresString
        posterImageView.kf.setImage(with: viewModel?.posterPath)
        
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 44
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    @IBAction func forceCrashButtonTapped(_ sender: AnyObject) {
        let numbers = [0]
        _ = numbers[1]
    }
}
