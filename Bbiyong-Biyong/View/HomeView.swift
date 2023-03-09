//
//  MainView.swift
//  Bbiyong-Biyong
//
//  Created by Jade Yoo on 2023/02/11.
//
//
import UIKit
import SnapKit

class HomeView: UIView {
    // MARK: - Properties
    private let username: String = UserDefaults.standard.string(forKey: "username") ?? ""
    
    private let maximum: Int = UserDefaults.standard.integer(forKey: "maximum")
    
    var total: Int = 0 {
        didSet {
            totalConsumptionLabel.text = total.numberToCurrency()
            remain = maximum - total
        }
    }
    
    private var remain: Int = 0 {
        didSet {
            remainAmountLabel.text = "남은 금액 : \(remain.numberToCurrency())"
            remainAmountLabel.textColor = remain < 0 ? .systemRed : .darkGray
        }
    }
    
    private let bbiyongImageView: UIImageView = {
        let iv = UIImageView()
        iv.image = UIImage(named: "testImage")
        iv.contentMode = .scaleAspectFit
        
        return iv
    }()

    private lazy var monthlyCostTitleLabel: UILabel = {
        let label = UILabel()
        label.text = "💸 \(username)님의 이번 달 소비"
        label.numberOfLines = 1
        label.textAlignment = .left
        label.font = .boldSystemFont(ofSize: 20)

        return label
    }()

    private lazy var statisticsTitleLabel: UILabel = {
        let label = UILabel()
        label.text = "📊 \(username)님의 통계"
        label.numberOfLines = 1
        label.textAlignment = .left
        label.font = .boldSystemFont(ofSize: 20)

        return label
    }()

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
    
    private let statisticsBackgroundView = UIView()
//    private let achievementBackgroundView = UIView()

    private lazy var stackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [bbiyongImageView, monthlyCostTitleLabel, monthlyCostBackgroundView, remainAmountLabel, statisticsTitleLabel, statisticsBackgroundView])
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

        [monthlyCostBackgroundView, statisticsBackgroundView].forEach {
            $0.backgroundColor = .secondarySystemGroupedBackground
            $0.layer.cornerRadius = 10
            $0.layer.shadowOffset = CGSize(width: 0, height: 5)
            $0.layer.shadowRadius = 10
            $0.layer.shadowOpacity = 0.2
        }
        
        [monthlyCostTitleLabel, statisticsTitleLabel].forEach {
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

        statisticsBackgroundView.snp.makeConstraints { make in
            make.height.equalTo(300)
        }
    }
}
