//
//  FavouriteViewControllerTest.swift
//  CryptoCurrencyTests
//
//  Created by Hoang Linh Nguyen on 22/9/2023.
//

import XCTest
@testable import CryptoCurrency

final class FavouriteViewControllerTest: XCTestCase {

    var sut: FavouriteViewController!

    override func setUpWithError() throws {
        sut = FavouriteViewController()
        sut.loadViewIfNeeded()
    }

    override func tearDownWithError() throws {
        try super.tearDownWithError()
        sut = nil
    }

    func testExample() throws {
        sut.viewDidLoad()
        sut.viewWillAppear(true)
    }
}
