//
//  HomeViewControllerTest.swift
//  CryptoCurrencyTests
//
//  Created by Hoang Linh Nguyen on 22/9/2023.
//

import XCTest
@testable import CryptoCurrency

final class HomeViewControllerTest: XCTestCase {

    var sut: HomeViewController!

    override func setUpWithError() throws {
        sut = HomeViewController()
        sut.loadViewIfNeeded()
    }

    override func tearDownWithError() throws {
        try super.tearDownWithError()
        sut = nil
    }

    func testExample() throws {
        sut.viewDidLoad()
        sut.viewWillAppear(true) 
        sut.viewWillDisappear(true)
        sut.textFieldShouldReturn(sut.searchTextField)
        sut.searchHandler(sut.searchTextField)
        sut.stockTableView.reloadData()
        sut.refresh(sut.stockTableView)
        XCTAssertEqual(sut.getCategoryId(categoryName: "price"), 0)
        XCTAssertEqual(sut.getCategoryId(categoryName: "marketCap"), 1)
        XCTAssertEqual(sut.getCategoryId(categoryName: "volume"), 2)
        XCTAssertEqual(sut.getCategoryId(categoryName: "change"), 3)
        XCTAssertEqual(sut.matchIdWithOrderBy(categoryId: 0), "price")
        XCTAssertEqual(sut.matchIdWithOrderBy(categoryId: 1), "marketCap")
        XCTAssertEqual(sut.matchIdWithOrderBy(categoryId: 2), "24hVolume")
        XCTAssertEqual(sut.matchIdWithOrderBy(categoryId: 3), "change")
        sut.loadMoreCoins()
        sut.getCoinRanking(categoryId: 0)
        sut.popUpButtonAction(id: 0)
    }
}


