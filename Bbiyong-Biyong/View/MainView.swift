//
//  MainView.swift
//  Bbiyong-Biyong
//
//  Created by Jade Yoo on 2023/02/11.
//
//
import UIKit
import SnapKit

class MainView: UIView {
    // MARK: - Properties
    private let bbiyongImageView: UIImageView = {
        let iv = UIImageView()
        iv.image = UIImage(named: "testImage")
        iv.contentMode = .scaleAspectFit
        
        return iv
    }()

    private let monthlyCostTitleLabel: UILabel = {
        let label = UILabel()
        label.text = "이번 달 소비"
        label.numberOfLines = 1
        label.textAlignment = .left
        label.font = .boldSystemFont(ofSize: 28)

        return label
    }()

    private let statisticsTitleLabel: UILabel = {
        let label = UILabel()
        label.text = "사용자님의 통계"
        label.numberOfLines = 1
        label.textAlignment = .left
        label.font = .boldSystemFont(ofSize: 28)

        return label
    }()

    private let achievementTitleLabel: UILabel = {
        let label = UILabel()
        label.text = "사용자님의 업적"
        label.numberOfLines = 1
        label.textAlignment = .left
        label.font = .boldSystemFont(ofSize: 28)

        return label
    }()

    private let monthlyCostBackgroundView = UIView()
    private let statisticsBackgroundView = UIView()
    private let achievementBackgroundView = UIView()

    private lazy var stackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [bbiyongImageView, monthlyCostTitleLabel, monthlyCostBackgroundView, statisticsTitleLabel, statisticsBackgroundView, achievementTitleLabel, achievementBackgroundView])
        stackView.axis = .vertical
        stackView.alignment = .fill
        stackView.distribution = .fillProportionally
        stackView.spacing = 10

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

        stackView.snp.makeConstraints { make in
            make.top.bottom.equalToSuperview()
            make.leading.trailing.equalToSuperview().inset(20)
        }

        [monthlyCostBackgroundView, statisticsBackgroundView, achievementBackgroundView].forEach {
            $0.backgroundColor = .lightGray
            $0.layer.cornerRadius = 10
            $0.layer.masksToBounds = true
        }
        
        [monthlyCostTitleLabel, statisticsTitleLabel, achievementTitleLabel].forEach {
            $0.snp.makeConstraints { make in
                make.height.lessThanOrEqualTo(60)
            }
        }
        
        bbiyongImageView.snp.makeConstraints { make in
            make.height.equalTo(300).priority(999)
        }

        monthlyCostBackgroundView.snp.makeConstraints { make in
            make.height.equalTo(100)
        }

        statisticsBackgroundView.snp.makeConstraints { make in
            make.height.equalTo(300)
        }

        achievementBackgroundView.snp.makeConstraints { make in
            make.height.equalTo(200)
        }
    }

}
