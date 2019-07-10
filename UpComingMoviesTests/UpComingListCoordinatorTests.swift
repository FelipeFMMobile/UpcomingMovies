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
  
  override func tearDown() {
   
  }
  
  func testCoordinatorDetailSegue_DetailTrue() {
    let storyboard = UIStoryboard.init(name: "UpComingListStoryboard", bundle: nil)
    guard let mockController = storyboard.instantiateInitialViewController() else { 
      fail() 
      return 
    }
    let coordinator: UpCommingCoordinatorProtocol = UpCommingCoordinator(controller: mockController)
    if let object = objectForContract(contract: "MovieDetail", MoviesDetailModelCodable.self) {
      let isOpen = coordinator.instantiateDetailSegue(detailMovie: object)
      expect(isOpen).to(beTrue())
    }
  }
  
  func testCoordinatorDetailSegue_DetailFail() {
    let mockController = UIViewController()
    let coordinator: UpCommingCoordinatorProtocol = UpCommingCoordinator(controller: mockController)
    if let object = objectForContract(contract: "MovieDetail", MoviesDetailModelCodable.self) {
      let isOpen = coordinator.instantiateDetailSegue(detailMovie: object)
      expect(isOpen).to(beFalse())
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
  
  func testPerformanceExample() {
    // This is an example of a performance test case.
    self.measure {
      // Put the code you want to measure the time of here.
    }
  }
  
}
