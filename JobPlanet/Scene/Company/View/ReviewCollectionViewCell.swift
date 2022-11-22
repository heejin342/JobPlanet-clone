//
//  ReviewCollectionViewCell.swift
//  JobPlanet
//
//  Created by 김희진 on 2022/11/20.
//

import UIKit
import Kingfisher

class ReviewCollectionViewCell: UICollectionViewCell {

    @IBOutlet var mainView: UIView!
    
    @IBOutlet var companyTitle: UILabel!
    @IBOutlet var companyLogo: UIImageView!
    @IBOutlet var companyRate: UILabel!
    @IBOutlet var companyIndustryName: UILabel!
    
    @IBOutlet var reviewUpdateDate: UILabel!
    @IBOutlet var reviewSummary: UILabel!
    @IBOutlet var reviewPros: UILabel!
    @IBOutlet var reviewCons: UILabel!
    
    let formatter = DateFormatter()
    
    override func awakeFromNib() {
        super.awakeFromNib()

        mainView.widthAnchor.constraint(equalToConstant: UIScreen.main.bounds.size.width).isActive = true
        companyLogo.layer.cornerRadius = 4
        companyLogo.layer.borderWidth = 1
        companyLogo.layer.borderColor = UIColor.JobPlanet.gray3.cgColor
        formatter.dateFormat = "yyyy-MM-dd'T'HH:mm'Z'"
    }
    
    func configureCell(with data: CellList) {
        guard let data = data.cellData as? ReviewCell else { return }

        companyLogo.kf.setImage(with: URL(string: data.logoPath))
        companyTitle.text = data.name
        companyRate.text = "\(data.rateTotalAvg)"
        companyIndustryName.text = data.industryName
        reviewSummary.text = data.reviewSummary
        reviewPros.text = data.pros
        reviewCons.text = data.cons
        
        guard let date = formatter.date(from: data.updateDate) else { return }
        reviewUpdateDate.text = date.toString(dateFormat: "yyyy.MM.dd")
    }
}
