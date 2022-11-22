//
//  UIViewController+Extension.swift
//  JobPlanet
//
//  Created by 김희진 on 2022/11/20.
//

import UIKit

extension UIViewController {    
    var mainStoryboard: UIStoryboard {
        return UIStoryboard(name: "Main", bundle: Bundle.main)
    }
    
    func instanceVC(name: String) -> UIViewController? {
        return self.mainStoryboard.instantiateViewController(withIdentifier: name)
    }
    
    func alert(_ message: String, completion: (() -> Void)? = nil) {
        DispatchQueue.main.async {
            let alert = UIAlertController(title: nil, message: message, preferredStyle: .alert)
            let okAction = UIAlertAction(title: "확인", style: .cancel) { _ in
                completion?()
            }
            
            alert.addAction(okAction)
            self.present(alert, animated: true)
        }
    }
}
