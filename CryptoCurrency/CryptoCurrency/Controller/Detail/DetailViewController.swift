//
//  DetailViewController.swift
//  CryptoCurrency
//
//  Created by Hoang Linh Nguyen on 12/9/2023.
//

import UIKit
import DGCharts

final class DetailViewController: UIViewController {
    @IBOutlet private weak var coinImageView: UIImageView!
    @IBOutlet private weak var coinNameLabel: UILabel!
    @IBOutlet private weak var coinPriceLabel: UILabel!
    @IBOutlet private weak var coinDesLabel: UILabel!
    @IBOutlet private weak var linkLabel: UILabel!
    @IBOutlet private weak var coinSymbolLabel: UILabel!
    @IBOutlet weak var backButton: UIButton!
    @IBOutlet weak var followButton: UIButton!
    @IBOutlet private weak var marketCapLabel: UILabel!
    @IBOutlet private weak var volume24hLabel: UILabel!
    @IBOutlet private weak var supplyLabel: UILabel!
    @IBOutlet private weak var changeRateLabel: UILabel!
    @IBOutlet private weak var chartContainerView: UIView!
    @IBOutlet weak var todayButton: UIButton!
    @IBOutlet weak var weekButton: UIButton!
    @IBOutlet weak var monthButton: UIButton!
    @IBOutlet weak var threeMonthButton: UIButton!
    @IBOutlet weak var yearButton: UIButton!
    @IBOutlet weak var threeYearButton: UIButton!

    private var coinDetailDictionary: [String: String] = [:]
    private var isFollow = false
    private var uuid = String.isEmpty
    var thisCoin: Coin?
    var currentButtonIndex = 0

    private var values: [ChartDataEntry] = []

    lazy var lineChartView: LineChartView = {
        let chartView = LineChartView()
        chartView.backgroundColor = UIColor.chartBackgroundColor

        let yAxis = chartView.leftAxis
        yAxis.labelFont = .boldSystemFont(ofSize: 12)
        yAxis.labelTextColor = UIColor.white
        yAxis.axisLineColor = UIColor.white
        yAxis.axisLineWidth = LayerSettings.chartLineWidth.rawValue
        yAxis.labelPosition = .outsideChart

        let xAxis = chartView.xAxis
        xAxis.labelPosition = .bottom
        xAxis.labelFont = .boldSystemFont(ofSize: 12)
        xAxis.labelTextColor = UIColor.white
        xAxis.axisLineColor = UIColor.white
        xAxis.axisLineWidth = LayerSettings.chartLineWidth.rawValue

        chartView.rightAxis.enabled = false
        chartView.legend.enabled = false

        return chartView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        getCoinDetail()
        getCoinSparkline(currentButtonIndex: currentButtonIndex)
        customizeView()
    }

    func setUuid(uuid: String) {
        self.uuid = uuid
    }

    private func getCoinDetail() {
        let timePeriod = "24h"
        let queue = DispatchQueue(label: "getCoinDetailQueue", qos: .utility)
        queue.async { [unowned self] in
            APIManager.shared.fetchCoinDetail(uuid: uuid, timePeriod: timePeriod, completion: { (coin: Coin) in
                self.passDetailToFavourite(uuid: coin.uuid,
                                           name: coin.name,
                                           symbol: coin.symbol,
                                           iconUrl: coin.iconUrl,
                                           color: coin.color ?? String.isEmpty,
                                           price: coin.price)
                self.thisCoin = coin
                self.checkFollowStatus()
                self.configDetailView()
            }, errorHandler: {
                self.popUpErrorAlert(message: "Error fetching data")
            })
        }
    }

    private func getCoinSparkline(currentButtonIndex: Int) {
        let timePeriod = convertIndexToTimePeriod(index: currentButtonIndex)
        DispatchQueue.main.async { [weak self] in
            if let uuid = self?.uuid {
                APIManager.shared.fetchCoinDetail(uuid: uuid, timePeriod: timePeriod, completion: { (coin: Coin) in
                    self?.values = []
                    if let sparkline = coin.sparkline {
                        sparkline.enumerated().forEach { (index, value) in
                            guard let value, let convertedValue = Double(value) else { return }
                            self?.values.append(ChartDataEntry(x: Double(index), y: convertedValue))
                        }
                    }
                    self?.addLineChartViewConstraints()
                }, errorHandler: {
                    self?.popUpErrorAlert(message: "Error fetching data")
                })
            }
        }
    }

    private func configChartData() {
        let set = LineChartDataSet(entries: values)
        set.mode = .linear
        set.drawCirclesEnabled = false
        set.lineWidth = LayerSettings.chartLineWidth.rawValue
        set.setColor(UIColor.white)
        let colorTop = UIColor.chartFillTop.cgColor
        let colorBottom = UIColor.chartFillBottom.cgColor
        let gradientColors = [colorTop, colorBottom] as CFArray
        let colorLocations: [CGFloat] = [LayerSettings.colorLocationTop.rawValue, LayerSettings.colorLocationBottom.rawValue]
        if let gradient = CGGradient.init(colorsSpace: CGColorSpaceCreateDeviceRGB(), colors: gradientColors, locations: colorLocations) {
            set.fill = LinearGradientFill(gradient: gradient, angle: LayerSettings.angle.rawValue)
        }
        set.drawFilledEnabled = true
        set.drawHorizontalHighlightIndicatorEnabled = false

        let data = LineChartData(dataSet: set)
        data.setDrawValues(false)
        lineChartView.data = data
    }

    private func addLineChartViewConstraints() {
        chartContainerView.addSubview(lineChartView)
        lineChartView.translatesAutoresizingMaskIntoConstraints = false
        lineChartView.center = chartContainerView.convert(chartContainerView.center, from: chartContainerView.superview)
        lineChartView.widthAnchor.constraint(equalTo: chartContainerView.widthAnchor, multiplier: 1.0).isActive = true
        lineChartView.heightAnchor.constraint(equalTo: chartContainerView.heightAnchor, multiplier: 1.0).isActive = true

        lineChartView.animate(xAxisDuration: LayerSettings.chartAppearDuration.rawValue)

        configChartData()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: animated)
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.setNavigationBarHidden(false, animated: animated)
    }

    private func passDetailToFavourite(uuid: String,
                                       name: String,
                                       symbol: String,
                                       iconUrl: String,
                                       color: String,
                                       price: String) {
        coinDetailDictionary["uuid"] = uuid
        coinDetailDictionary["name"] = name
        coinDetailDictionary["symbol"] = symbol
        coinDetailDictionary["iconUrl"] = iconUrl
        coinDetailDictionary["color"] = color
        coinDetailDictionary["price"] = price
    }

    private func checkFollowStatus() {
        _ = FavouriteManager.favourites.map({ favourite in
            if favourite.uuid == thisCoin?.uuid {
                self.isFollow = true
            }
        })
    }

    private func customizeView() {
        coinImageView.layer.cornerRadius = LayerSettings.radius.rawValue
        followButton.layer.cornerRadius = LayerSettings.radius.rawValue
        configCurrentButtonIndex(currentButtonIndex: currentButtonIndex)
        let underlineAttribute = [NSAttributedString.Key.underlineStyle: NSUnderlineStyle.thick.rawValue]
        let underlineAttributedString = NSAttributedString(string: "StringWithUnderLine", attributes: underlineAttribute)
        linkLabel.attributedText = underlineAttributedString
        linkLabel.isUserInteractionEnabled = true
        linkLabel.addGestureRecognizer(UITapGestureRecognizer(target: self,
                                                              action: #selector(linkLabelClicked)))
    }

    @objc
    func linkLabelClicked() {
        guard let urlString = thisCoin?.websiteUrl,
              let url = URL(string: urlString) else {
            return
        }
        UIApplication.shared.open(url)
    }

    private func configDetailView() {
        if let iconURL = thisCoin?.iconUrl {
            ViewManager.shared.setImagePNG(stringURL: iconURL, imageView: coinImageView, viewController: self)
        }
        if let imageColor = thisCoin?.color {
            coinImageView.backgroundColor = imageColor == String.blackColor
            ? UIColor.white
            : UIColor.init(hexString: imageColor)
        }
        coinNameLabel.text = thisCoin?.name
        coinSymbolLabel.text = thisCoin?.symbol
        linkLabel.text = thisCoin?.websiteUrl
        if let price = thisCoin?.price {
            if let decimal = Double(price) {
                coinPriceLabel.text = "$\(String(format: "%.2f", decimal))"
            }
        }
        followButton.backgroundColor = isFollow ? UIColor.gray : UIColor.mainColor
        followButton.setTitle(isFollow ? "Following" : "Follow", for: .normal)
        coinDesLabel.text = thisCoin?.description
        if let marketCap = thisCoin?.marketCap,
           let volume24h = thisCoin?.volume24h,
           let supplyTotal = thisCoin?.supply?.total {
            if let marketCapValue = Double(marketCap),
               let volume24hValue = Double(volume24h),
               let supplyTotalValue = Double(supplyTotal) {
                marketCapLabel.text = "$\(marketCapValue.formatted())"
                volume24hLabel.text = "$\(volume24hValue.formatted())"
                supplyLabel.text = supplyTotalValue.formatted()
            }
        }

        if let changeRate = thisCoin?.change {
            let isChanged = ViewManager.shared.checkChangeRate(rate: changeRate)
            changeRateLabel.text = "\(changeRate)%"
            changeRateLabel.textColor = isChanged ? .systemGreen : .systemRed
        }
    }

    func configCurrentButtonIndex(currentButtonIndex: Int) {
        let buttons = [todayButton, weekButton, monthButton, threeMonthButton, yearButton, threeYearButton]
        buttons.enumerated().forEach { (index, button) in
            button?.backgroundColor = index == currentButtonIndex ? UIColor.mainColor : UIColor.clear
            button?.layer.cornerRadius = LayerSettings.radius.rawValue
        }
    }

    private func convertIndexToTimePeriod(index: Int) -> String {
        switch index {
        case 1:
            return "7d"
        case 2:
            return "30d"
        case 3:
            return "3m"
        case 4:
            return "1y"
        case 5:
            return "3y"
        default:
            return "24h"
        }
    }

    @IBAction func handleBackButton(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }

    @IBAction func handleFollowButton(_ sender: UIButton) {
        followButton.backgroundColor = isFollow ? UIColor.mainColor : UIColor.gray
        followButton.setTitle(isFollow ? "Follow" : "Following", for: .normal)
        if let uuid = thisCoin?.uuid {
            if isFollow {
                CoreDataManager.shared.deleteItem(uuid: uuid)
            } else {
                CoreDataManager.shared.saveItem(favouriteCoinInfo: coinDetailDictionary)
            }
        }
        isFollow.toggle()
    }

    private func buttonHandler() {
        configCurrentButtonIndex(currentButtonIndex: self.currentButtonIndex)
        getCoinSparkline(currentButtonIndex: self.currentButtonIndex)
    }

    @IBAction func handleTodayButton(_ sender: UIButton) {
        self.currentButtonIndex = 0
        buttonHandler()
    }

    @IBAction func handleWeekButton(_ sender: UIButton) {
        self.currentButtonIndex = 1
        buttonHandler()
    }

    @IBAction func handleMonthButton(_ sender: UIButton) {
        self.currentButtonIndex = 2
        buttonHandler()
    }

    @IBAction func handleThreeMonthButton(_ sender: UIButton) {
        self.currentButtonIndex = 3
        buttonHandler()
    }

    @IBAction func handleYearButton(_ sender: UIButton) {
        self.currentButtonIndex = 4
        buttonHandler()
    }

    @IBAction func handleThreeYearButton(_ sender: UIButton) {
        self.currentButtonIndex = 5
        buttonHandler()
    }
}
