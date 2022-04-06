//
//  UpcomingListTests.swift
//  UpComingMoviesTests
//
//  Created by FMMobile on 02/06/2019.
//  Copyright © 2019 FMMobile. All rights reserved.
//

import XCTest
@testable import UpComingMovies
import Nimble

class UpComingListCoordinatorTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
    }
    
    func testCoordinatorDetailSegue_DetailTrue() {
        let coordinator = UpCommingCoordinator(nav: UINavigationController())
        if let object = objectForContract(contract: "MovieDetail", MoviesDetailModelCodable.self) {
            let view = coordinator.instantiateDetail(object)
            expect(view).to(beAKindOf(DetailUpComingListTableViewController.self))
        }
    }
    
    func objectForContract<T>(contract: String, _ type: T.Type) -> T? where T: Decodable {
        if let path = Bundle(for: UpComingListApiTests.self).path(forResource: contract, ofType: "json") {
            do {
                let data = try Data(contentsOf: URL(fileURLWithPath: path), options: .mappedIfSafe)
                let decoder = JSONDecoder()
                let result = try decoder.decode(type, from: data)
                return result
            } catch {
                // handle error
            }
        }
        return nil
    }
}
