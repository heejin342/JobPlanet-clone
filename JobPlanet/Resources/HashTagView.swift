//
//  HashTagView.swift
//  JobPlanet
//
//  Created by 김희진 on 2022/11/21.
//

import UIKit
import SnapKit

final class HashTagView: UIView {
    
    internal lazy var textLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "AppleSDGothicNeo-Regular", size: 11)
        label.textColor = UIColor.JobPlanet.gray2
        return label
    }()
    
    convenience init(text: String, viewBackgroundColor: UIColor = .white) {
        self.init(frame: .zero)
        configure(label: text, viewBackgroundColor: viewBackgroundColor)
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }

    private func configure(label: String, viewBackgroundColor: UIColor) {
        self.backgroundColor = viewBackgroundColor
        textLabel.text = label
        
        self.addSubview(textLabel)
        self.layer.cornerRadius = 4
        self.layer.borderColor = UIColor.JobPlanet.gray3.cgColor
        self.layer.borderWidth = 1
        
        textLabel.snp.makeConstraints {
            $0.top.bottom.equalToSuperview()
            $0.leading.trailing.equalToSuperview().inset(8)
        }
    }
}

// 검색, 통신 에러처리 -> 팝업extension, identifier extension
// MVVM
// 스택뷰 오토 사이징
// 테이블 뷰 아래 데이터 넣기
// 검색 결과 없을때 화면
