//
//  UpComingListTableViewController.swift
//  UpComingMovies
//
//  Created by Felipe Menezes on 30/03/2018.
//  Copyright © 2018 FMMobile. All rights reserved.
//

import UIKit
import SwiftUI

protocol LoaderHostingState {
    func startLoad()
    func titleForView() -> String?
}

class HostingController<T: LoaderHostingState & View>: UIHostingController<T> {

    public init(uiView: T) {
        super.init(rootView: uiView)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    @MainActor @objc required dynamic init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
