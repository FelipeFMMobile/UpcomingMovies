//
//  UpComingLisTableView.swift
//  UpComingMovies
//
//  Created by Felipe Menezes on 23/02/22.
//  Copyright © 2022 FMMobile. All rights reserved.
//

import Foundation

class UpComingListTableView: UIView, ViewCodeProtocol {

    lazy var tableView: UITableView = {
        let view = UITableView(frame: .zero)
        view.translatesAutoresizingMaskIntoConstraints = false
        view.rowHeight = UITableView.automaticDimension
        view.estimatedRowHeight = 44

        return view
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = .white
        setup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupViews() {
        self.addSubview(tableView)
        
        tableView.register(UINib(nibName: ListMoviesTableViewCell.nib, bundle: nil),
                           forCellReuseIdentifier: ListMoviesTableViewCell.identifier)
    }

    func setupConstraints() {
        let constraints = [
            tableView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: 0),
            tableView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 0),
            tableView.topAnchor.constraint(equalTo: self.topAnchor, constant: 0),
            tableView.bottomAnchor.constraint(equalTo: self.safeAreaLayoutGuide.bottomAnchor, constant: 0),
            tableView.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            tableView.centerYAnchor.constraint(equalTo: self.centerYAnchor)
        ]
        NSLayoutConstraint.activate(constraints)
        
//        loginTextField.centerYAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.centerYAnchor, constant: -100).isActive = true
//        loginTextField.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -10).isActive = true
//        loginTextField.leadingAnchor.constraint(equalTo: self.loginLabel.trailingAnchor, constant: 10).isActive = true
//        loginTextField.widthAnchor.constraint(equalTo:self.loginLabel.widthAnchor).isActive = true
//        loginTextField.heightAnchor.constraint(equalToConstant: 40).isActive = true

    }
}

//
//import Foundation
//import UIKit
//
//class CustomTableViewCell: UITableViewCell {
//
//    let imgUser = UIImageView()
//    let labUerName = UILabel()
//    let labMessage = UILabel()
//    let labTime = UILabel()
//
//    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
//        super.init(style: style, reuseIdentifier: reuseIdentifier)
//
//        imgUser.backgroundColor = UIColor.blue
//
//        imgUser.translatesAutoresizingMaskIntoConstraints = false
//        labUerName.translatesAutoresizingMaskIntoConstraints = false
//        labMessage.translatesAutoresizingMaskIntoConstraints = false
//        labTime.translatesAutoresizingMaskIntoConstraints = false
//
//        contentView.addSubview(imgUser)
//        contentView.addSubview(labUerName)
//        contentView.addSubview(labMessage)
//        contentView.addSubview(labTime)
//
//        let viewsDict = [
//            "image" : imgUser,
//            "username" : labUerName,
//            "message" : labMessage,
//            "labTime" : labTime,
//            ] as [String : Any]
//
//        contentView.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|-[image(10)]", options: [], metrics: nil, views: viewsDict))
//        contentView.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:[labTime]-|", options: [], metrics: nil, views: viewsDict))
//        contentView.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|-[username]-[message]-|", options: [], metrics: nil, views: viewsDict))
//        contentView.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|-[username]-[image(10)]-|", options: [], metrics: nil, views: viewsDict))
//        contentView.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|-[message]-[labTime]-|", options: [], metrics: nil, views: viewsDict))
//    }
//
//    required init?(coder aDecoder: NSCoder) {
//        fatalError("init(coder:) has not been implemented")
//    }
//
//}
