//
//  KevinButton.swift
//  Kevin
//
//  Created by heerucan on 2023/04/30.
//

import UIKit

import SnapKit

final class KevinButton: UIButton {
    
    enum KevinButtonType {
        case share
        case card
        case result
        
        var title: String {
            switch self {
            case .share: return StringLiteral.Button.share
            case .card: return StringLiteral.Button.card
            case .result: return StringLiteral.Button.result
            }
        }
        
        var backgroundColor: UIColor {
            switch self {
            case .share: return .gray100
            case .card: return .black
            case .result: return .green100
            }
        }
    }
    
    private var type: KevinButtonType = .result
    
    init(type: KevinButtonType) {
        self.type = type
        super.init(frame: .zero)
        setUI()
        setLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setUI() {
        setTitle(type.title, for: .normal)
        setTitleColor(.white, for: .normal)
        setTitleColor(.gray200, for: .highlighted)
        titleLabel?.font = .kevinFont(type: .black16)
        backgroundColor = type.backgroundColor
        self.makeCorner(width: 0, radius: 25)
    }
    
    private func setLayout() {
        self.snp.makeConstraints { make in
            make.width.equalTo(145)
            make.height.equalTo(50)
        }
    }
}
