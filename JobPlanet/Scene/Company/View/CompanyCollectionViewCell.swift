//
//  CompanyCollectionViewCell.swift
//  JobPlanet
//
//  Created by 김희진 on 2022/11/19.
//

import UIKit
import Kingfisher

class CompanyCollectionViewCell: UICollectionViewCell {

    @IBOutlet var mainView: UIView!

    @IBOutlet var companyLogo: UIImageView!
    @IBOutlet var companyTitle: UILabel!
    @IBOutlet var companyRate: UILabel!
    @IBOutlet var companyIndustryName: UILabel!
    @IBOutlet var companySalaryAverage: UILabel!

    @IBOutlet var reviewSummery: UILabel!
    @IBOutlet var reviewUpdateDate: UILabel!
    
    @IBOutlet var intervewQuestion: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        mainView.widthAnchor.constraint(equalToConstant: UIScreen.main.bounds.size.width).isActive = true
        companyLogo.layer.cornerRadius = 4
        companyLogo.layer.borderWidth = 1
        companyLogo.layer.borderColor = UIColor.JobPlanet.gray3.cgColor
    }
    
    func configureCell(with data: CellList) {
        guard let data = data.cellData as? CompanyCell else { return }

        companyLogo.kf.setImage(with: URL(string: data.logoPath))
        companyTitle.text = data.name
        companyRate.text = "\(data.rateTotalAvg)"
        companyIndustryName.text = data.industryName
        companySalaryAverage.text = "\(data.salaryAvg)".makeComma
        reviewSummery.text = data.reviewSummary
        reviewUpdateDate.text = data.updateDate
        intervewQuestion.text = data.interviewQuestion
    }
}
