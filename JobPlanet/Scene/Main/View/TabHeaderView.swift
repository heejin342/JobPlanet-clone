//
//  TabHeaderView.swift
//  JobPlanet
//
//  Created by 김희진 on 2022/11/19.
//

import UIKit

class TabHeaderView: UICollectionReusableView {
    
    @IBOutlet weak var recruitButton: UIButton!
    @IBOutlet weak var companyButton: UIButton!
    
    var buttonTapped: ((Int) -> Void)?
        
    @IBAction func tab(_ sender: UIButton) {
        if sender == recruitButton {
            self.buttonTapped?(TabButtonType.recruit.rawValue)
        } else {
            self.buttonTapped?(TabButtonType.company.rawValue)
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    func setTabButton(toggle: TabButtonType) {
        switch toggle {
        case .company:
            self.recruitButton.backgroundColor = .white
            self.recruitButton.layer.borderWidth = 1
            self.recruitButton.layer.cornerRadius = 15
            self.recruitButton.layer.borderColor = UIColor.JobPlanet.gray3.cgColor
            self.recruitButton.titleLabel?.textColor = UIColor.JobPlanet.gray1
            self.recruitButton.titleLabel?.font = UIFont(name: "AppleSDGothicNeo-Regular", size: 15)

            self.companyButton.backgroundColor = UIColor.JobPlanet.green
            self.companyButton.layer.borderWidth = 1
            self.companyButton.layer.cornerRadius = 15
            self.companyButton.layer.borderColor = UIColor.JobPlanet.green.cgColor
            self.companyButton.titleLabel?.textColor = .white
            self.companyButton.titleLabel?.font = UIFont(name: "AppleSDGothicNeo-Bold", size: 15)

        case .recruit:
            self.companyButton.backgroundColor = .white
            self.companyButton.layer.borderWidth = 1
            self.companyButton.layer.cornerRadius = 15
            self.companyButton.layer.borderColor = UIColor.JobPlanet.gray3.cgColor
            self.companyButton.titleLabel?.textColor = UIColor.JobPlanet.gray1
            self.companyButton.titleLabel?.font = UIFont(name: "AppleSDGothicNeo-Regular", size: 15)

            self.recruitButton.backgroundColor = UIColor.JobPlanet.green
            self.recruitButton.layer.borderWidth = 1
            self.recruitButton.layer.cornerRadius = 15
            self.recruitButton.layer.borderColor = UIColor.JobPlanet.green.cgColor
            self.recruitButton.titleLabel?.textColor = .white
            self.recruitButton.titleLabel?.font = UIFont(name: "AppleSDGothicNeo-Bold", size: 15)
        }
    }
    
}
