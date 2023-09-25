//
//  ExchangeViewControllerTest.swift
//  CryptoCurrencyTests
//
//  Created by Hoang Linh Nguyen on 22/9/2023.
//

import XCTest
@testable import CryptoCurrency

final class ExchangeViewControllerTest: XCTestCase {

    var sut: ExchangeViewController!

    override func setUpWithError() throws {
        sut = ExchangeViewController()
        sut.loadViewIfNeeded()
    }

    override func tearDownWithError() throws {
        try super.tearDownWithError()
        sut = nil
    }

    func testExample() throws {
        sut.viewDidLoad()
        sut.setCurrentCoinRate(rate: 0.0)
        sut.setCurrentMoneyRate(rate: 0.0)
        sut.handleTextFieldChanged(sut.coinTextField)
        sut.handleExchangeButton(sut.exchangeButton)
        sut.moneyViewHandler()
    }
}
