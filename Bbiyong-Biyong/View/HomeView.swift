//
//  MainView.swift
//  Bbiyong-Biyong
//
//  Created by Jade Yoo on 2023/02/11.
//
//
import UIKit
import SnapKit
//import Charts

class HomeView: UIView {
    // MARK: - Properties
    var username: String = UserDefaults.standard.string(forKey: "username") ?? "" {
        didSet {
            monthlyCostTitleLabel.text = "💸 \(username)님의 이번 달 소비"
//            statisticsTitleLabel.text = "📊 \(username)님의 통계"
        }
    }
    
    var maximum: Int = UserDefaults.standard.integer(forKey: "maximum") {
        didSet {
            remain = maximum - total
            updateImage(propotion: Double(total) / Double(maximum))
        }
    }
    
    var total: Int = 0 {
        didSet {
            totalConsumptionLabel.text = total.numberToCurrency()
            remain = maximum - total
            
            updateImage(propotion: Double(total) / Double(maximum))
        }
    }
    
    private var remain: Int = 0 {
        didSet {
            remainAmountLabel.text = remain < 0 ? "초과 금액 : \((-remain).numberToCurrency())" : "남은 금액 : \(remain.numberToCurrency())"
            remainAmountLabel.textColor = remain < 0 ? .systemRed : .darkGray
        }
    }
    
    let bbiyongImageView: UIImageView = {
        let iv = UIImageView()
        iv.image = UIImage(named: "basicDino")
        iv.contentMode = .scaleAspectFit
        
        return iv
    }()

    private lazy var monthlyCostTitleLabel: UILabel = {
        let label = UILabel()
        label.text = "💸 \(username)님의 이번 달 소비"
        label.numberOfLines = 1
        label.textAlignment = .left
//        label.font = .boldSystemFont(ofSize: 20)

        return label
    }()

//    private lazy var statisticsTitleLabel: UILabel = {
//        let label = UILabel()
//        label.text = "📊 \(username)님의 통계"
//        label.numberOfLines = 1
//        label.textAlignment = .left
//        label.font = .boldSystemFont(ofSize: 20)
//
//        return label
//    }()

//    private lazy var achievementTitleLabel: UILabel = {
//        let label = UILabel()
//        label.text = "🏆 \(username)님의 업적"
//        label.numberOfLines = 1
//        label.textAlignment = .left
//        label.font = .boldSystemFont(ofSize: 20)
//
//        return label
//    }()

    private let monthlyCostBackgroundView = UIView()
    
    let totalConsumptionLabel: UILabel = {
        let label = UILabel()
        label.text = "원"
        label.font = .boldSystemFont(ofSize: 25)
        label.textAlignment = .right
        return label
    }()
    
    private lazy var remainAmountLabel: UILabel = {
        let label = UILabel()
        label.text = ""
        label.textAlignment = .right
        label.textColor = .darkGray
        return label
    }()
    
//    private let pieChart: PieChartView = {
//        let chart = PieChartView()
//        chart.noDataText = "데이터 없음"
//        return chart
//    }()
//    private let achievementBackgroundView = UIView()

    private lazy var stackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [bbiyongImageView, monthlyCostTitleLabel, monthlyCostBackgroundView, remainAmountLabel])
        stackView.axis = .vertical
        stackView.alignment = .fill
        stackView.distribution = .fill
        stackView.spacing = 20
        stackView.setCustomSpacing(30, after: bbiyongImageView)
        stackView.setCustomSpacing(30, after: remainAmountLabel)

        return stackView
    }()

    // MARK: - Life cycle
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
        setFonts()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Helpers
    func configure() {
        addSubview(stackView)
        monthlyCostBackgroundView.addSubview(totalConsumptionLabel)

        stackView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(30)
            make.bottom.equalToSuperview()
            make.leading.trailing.equalToSuperview().inset(20)
        }

        [monthlyCostBackgroundView].forEach {
            $0.backgroundColor = .secondarySystemGroupedBackground
            $0.layer.cornerRadius = 10
            $0.layer.shadowOffset = CGSize(width: 0, height: 5)
            $0.layer.shadowRadius = 10
            $0.layer.shadowOpacity = 0.2
        }
        
        [monthlyCostTitleLabel].forEach {
            $0.snp.makeConstraints { make in
                make.height.lessThanOrEqualTo(60)
            }
        }
        
        bbiyongImageView.snp.makeConstraints { make in
            make.height.equalTo(300).priority(999)
        }

        monthlyCostBackgroundView.snp.makeConstraints { make in
            make.height.equalTo(80)
        }
        
        totalConsumptionLabel.snp.makeConstraints { make in
            make.centerY.equalTo(monthlyCostBackgroundView)
            make.trailing.equalTo(monthlyCostBackgroundView).inset(20)
        }

//        pieChart.snp.makeConstraints { make in
//            make.height.equalTo(300)
//        }
    }
    
    func updateImage(propotion: Double) {
        var imageName: String = MainImage[0]
        
        switch propotion {
        case 0..<0.2:
            imageName = MainImage[0]
        case 0.2..<0.4:
            imageName = MainImage[1]
        case 0.4..<0.6:
            imageName = MainImage[2]
        case 0.6..<0.8:
            imageName = MainImage[3]
        case 0.8..<1:
            imageName = MainImage[4]
        case 1..<1.5:
            imageName = MainImage[5]
        default:
            imageName = MainImage[6]
        }
        
        bbiyongImageView.image = UIImage(named: imageName)
    }
    
    func setFonts() {
        monthlyCostTitleLabel.font = UIFont().customBoldTitleFont
        totalConsumptionLabel.font = UIFont().customExtraLargeFont
        remainAmountLabel.font = UIFont().customTextFont
    }
}
