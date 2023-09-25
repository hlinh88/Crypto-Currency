//
//  DetailViewControllerTest.swift
//  CryptoCurrencyTests
//
//  Created by Hoang Linh Nguyen on 22/9/2023.
//

import XCTest
@testable import CryptoCurrency

final class DetailViewControllerTest: XCTestCase {

    var sut: DetailViewController!

    override func setUpWithError() throws {
        sut = DetailViewController()
        sut.loadViewIfNeeded()
    }

    override func tearDownWithError() throws {
        try super.tearDownWithError()
        sut = nil
    }

    func testExample() throws {
        sut.setUuid(uuid: "abcdxyz")
        let coin = Coin(uuid:  "Qwsogvtv82FCd",
                        symbol: "BTC",
                        name: "Bitcoin",
                        iconUrl: "https://cdn.coinranking.com/bOabBYkcX/bitcoin_btc.svg",
                        price: "26693.636394821628",
                        change: "-0.40")

        sut.viewDidLoad()
        sut.thisCoin = coin
        sut.viewWillAppear(true)
        sut.viewWillDisappear(true)
        sut.handleBackButton(sut.backButton)
        sut.handleFollowButton(sut.followButton)
        sut.handleTodayButton(sut.todayButton)
        sut.handleWeekButton(sut.weekButton)
        sut.handleMonthButton(sut.monthButton)
        sut.handleThreeMonthButton(sut.threeMonthButton)
        sut.handleYearButton(sut.yearButton)
        sut.handleThreeYearButton(sut.threeYearButton)
        sut.linkLabelClicked()
        sut.configCurrentButtonIndex(currentButtonIndex: sut.currentButtonIndex)
    }

}
