//
//  ListMoviesTableViewCell.swift
//  UpComingMovies
//
//  Created by Felipe Menezes on 01/04/2018.
//  Copyright © 2018 FMMobile. All rights reserved.
//

import UIKit
import Kingfisher

class ListMoviesTableViewCell: UITableViewCell {
  
  public static var identifier = "ListMovieCell"
  public static var nib = "ListMoviesCell"
  
  @IBOutlet weak var posterImageView: UIImageView!
  @IBOutlet weak var titleLabel: UILabel!
  @IBOutlet weak var genreLabel: UILabel!
  @IBOutlet weak var releaseLabel: UILabel!
    
  override func awakeFromNib() {
    super.awakeFromNib()
  }
  
  func drawCell(cellModel: ListMoviesCellModel) {
    titleLabel.text = cellModel.title
    genreLabel.text = cellModel.genreTitle
    releaseLabel.text = cellModel.releaseDate
    posterImageView.kf.setImage(with: cellModel.posterPath)
  }
  
  override func setSelected(_ selected: Bool, animated: Bool) {
    super.setSelected(selected, animated: animated)
    
    // Configure the view for the selected state
  }
  
}
