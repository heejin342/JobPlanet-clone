//
//  RecuitCollectionViewCell.swift
//  JobPlanet
//
//  Created by 김희진 on 2022/11/16.
//

import UIKit
import Kingfisher
import RxSwift

class RecuitCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet var companyLogo: UIImageView!
    @IBOutlet var companyRecruitName: UILabel!
    @IBOutlet var companyRate: UILabel!
    @IBOutlet var companyName: UILabel!
    @IBOutlet var companyReward: UILabel!
    @IBOutlet var companyAppealView: UIView!
    var companyAppealTag: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.spacing = 4
        return stackView
    }()

    var disposeBag = DisposeBag()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        companyLogo.layer.cornerRadius = 8
        companyAppealView.addSubview(companyAppealTag)
        companyAppealTag.snp.makeConstraints { make in
            make.top.bottom.leading.equalToSuperview()
        }
    }
    
    func configureCell(with data: RecruitList) {
        companyLogo.kf.setImage(with: URL(string: data.imageUrl))
        companyRecruitName.text = data.title
        
        let rate = data.company.ratings.reduce(0.0) { $0 + $1.rating } / Double(data.company.ratings.count)
        companyRate.text = "\(String(format: "%.1f", rate))"
        companyName.text = data.company.name
        companyReward.text = "축하금: " + "\(data.reward)".makeComma + "만원"
        
        let tagArray = data.appeal.components(separatedBy: ", ").filter { $0 != "" }
        if tagArray.count > 0 {
            Observable.from(tagArray)
                .take(1)
                .subscribe(onNext: {
                    let hashTagView = HashTagView(text: $0)
                    self.companyAppealTag.addArrangedSubview(hashTagView)
                    hashTagView.snp.makeConstraints { make in
                        make.leading.equalToSuperview()
                    }
                }).disposed(by: disposeBag)
            
        }
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
        for view in self.companyAppealTag.subviews {
            view.removeFromSuperview()
        }
        disposeBag = DisposeBag()
    }
}
