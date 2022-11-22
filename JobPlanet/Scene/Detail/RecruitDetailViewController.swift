//
//  RecruitDetailViewController.swift
//  JobPlanet
//
//  Created by 김희진 on 2022/11/21.
//

import UIKit
import Kingfisher

class RecruitDetailViewController: UIViewController {

    @IBOutlet var recruitImageView: UIImageView!
    @IBOutlet var recruitTitle: UILabel!
    @IBOutlet var recruiteCompany: UILabel!
    
    var data: RecruitList!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.isNavigationBarHidden = false
        
        recruitImageView.kf.setImage(with: URL(string: data?.imageUrl ?? ""))
        recruitImageView.layer.cornerRadius = 4
        recruitImageView.layer.borderWidth = 1
        recruitImageView.layer.borderColor = UIColor.JobPlanet.gray3.cgColor
        recruitImageView.contentMode = .scaleAspectFit

        recruitTitle.text = data?.title
        recruiteCompany.text = data?.company.name
    }
}
