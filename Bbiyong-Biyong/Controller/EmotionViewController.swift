//
//  EmotionViewController.swift
//  Bbiyong-Biyong
//
//  Created by Jade Yoo on 2023/03/07.
//

import UIKit
import SnapKit

class EmotionViewController: UIViewController {
    // MARK: - Properties
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "감정 선택"
        label.numberOfLines = 1
        label.textAlignment = .center
        label.font = .boldSystemFont(ofSize: 20)
        label.adjustsFontSizeToFitWidth = true
        return label
    }()
    
    private let subtitleLabel: UILabel = {
        let label = UILabel()
        label.text = "어떤 감정때문에 삐용비용을 사용했나요?"
        label.numberOfLines = 1
        label.font = .systemFont(ofSize: 15)
        label.adjustsFontSizeToFitWidth = true
        label.textAlignment = .center
        label.textColor = .secondaryLabel
        return label
    }()
    
    private lazy var collectionView: UICollectionView = {
        let view = UICollectionView(frame: .zero, collectionViewLayout: self.flowLayout)
        view.isScrollEnabled = false
        //view.showsHorizontalScrollIndicator = false
        //view.showsVerticalScrollIndicator = false
        view.contentInset = .zero
        view.backgroundColor = .clear
        //view.clipsToBounds = true
        view.register(EmotionCell.self, forCellWithReuseIdentifier: EmotionCell.identifier)
        return view
      }()
    
    private let flowLayout: UICollectionViewFlowLayout = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.minimumInteritemSpacing = 1.0
        return layout
      }()
    
    var delegate: SendDataDelegate?
    // MARK: - Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.dataSource = self
        collectionView.delegate = self
        
        configure()
    }

    // MARK: - Helpers
    func configure() {
        view.backgroundColor = .systemBackground
        
        view.addSubview(titleLabel)
        titleLabel.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide).offset(30)
            make.leading.trailing.equalToSuperview()
        }
        
        view.addSubview(subtitleLabel)
        subtitleLabel.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(20)
            make.leading.trailing.equalToSuperview()
        }
        
        view.addSubview(collectionView)
        collectionView.snp.makeConstraints { make in
            make.top.equalTo(subtitleLabel.snp.bottom).offset(30)
            make.leading.trailing.bottom.equalToSuperview().inset(10)
        }
    }
}

// MARK: - UICollectionViewDataSource
extension EmotionViewController: UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 8
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: EmotionCell.identifier, for: indexPath) as! EmotionCell
        
        cell.setImage(imageName: EmotionImage[indexPath.row])

//        switch indexPath.section {
//        case 0:
//            cell.setImage(imageName: EmotionImage[indexPath.row])
//        case 1:
//            cell.setImage(imageName: EmotionImage[indexPath.row + 4])
//        default:
//            break
//        }
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        delegate?.reciveData(response: indexPath.row)
        dismiss(animated: true)
    }
    
    func collectionView(_ collectionView: UICollectionView, didHighlightItemAt indexPath: IndexPath) {
        guard let cell = collectionView.cellForItem(at: indexPath) else { return }
        cell.layer.borderWidth = 2.0
        cell.layer.cornerRadius = cell.layer.frame.height / 2
        cell.layer.borderColor = UIColor.systemGreen.cgColor
    }
    
}

// MARK: - UICollectionViewDelegateFlowLayout
extension EmotionViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = collectionView.frame.width / 4 - 5
        return CGSize(width: width, height: width)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 5
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 5
    }
}
