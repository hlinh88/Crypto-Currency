//
//  NewsViewControllerTest.swift
//  CryptoCurrencyTests
//
//  Created by Hoang Linh Nguyen on 22/9/2023.
//

import XCTest
@testable import CryptoCurrency

final class NewsViewControllerTest: XCTestCase {

    var sut: NewsViewController!

    override func setUpWithError() throws {
        sut = NewsViewController()
        sut.loadViewIfNeeded()
    }

    override func tearDownWithError() throws {
        try super.tearDownWithError()
        sut = nil
    }

    func testExample() throws {
        sut.viewDidLoad()
    }
}
