//
//  KevinNavigationBar.swift
//  Kevin
//
//  Created by heerucan on 2023/05/01.
//

import UIKit

import SnapKit

final class KevinNavigationBar: UIView {
    
    enum NavigationType {
        case main
        case write
        case detail
        case analysis
        case setting
        
        var left: UIImage? {
            switch self {
            case .main: return nil
            default: return Image.back
            }
        }
        
        var right: UIImage? {
            switch self {
            case .main: return Image.setting
            default: return nil
            }
        }
        
        var rightTitle: String? {
            switch self {
            case .write: return StringLiteral.Button.analysis
            case .detail: return StringLiteral.Button.edit
            case .analysis: return StringLiteral.Button.ok
            default: return nil
            }
        }
    }
    
    private var type: NavigationType = .main
    
    let leftBarButton = UIButton()
    let rightBarButton = UIButton()
        
    init(type: NavigationType) {
        self.type = type
        super.init(frame: .zero)
        setLayout()
        setIcon()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setLayout() {
        addSubviews([leftBarButton, rightBarButton])
        
        self.snp.makeConstraints { make in
            make.height.equalTo(MatrixLiteral.naviHeight)
        }
        
        leftBarButton.snp.makeConstraints { make in
            make.top.bottom.equalToSuperview()
            make.leading.equalToSuperview().inset(4)
            make.width.height.equalTo(MatrixLiteral.buttonSize)
        }
        
        rightBarButton.snp.makeConstraints { make in
            make.top.bottom.equalToSuperview()
            make.trailing.equalToSuperview().inset(7)
            make.width.height.equalTo(MatrixLiteral.buttonSize)
        }
    }
    
    private func setIcon() {
        if type.left != nil {
            leftBarButton.setImage(type.left, for: .normal)
            leftBarButton.setImage(type.left?.withTintColor(.gray200, renderingMode: .alwaysOriginal),
                                   for: .highlighted)
        }
        
        if type.right != nil {
            rightBarButton.setImage(type.right, for: .normal)
            rightBarButton.setImage(type.right?.withTintColor(.gray200, renderingMode: .alwaysOriginal),
                                    for: .highlighted)
        }
        
        if type.rightTitle != nil {
            rightBarButton.setTitle(type.rightTitle, for: .normal)
            rightBarButton.setTitleColor(.black, for: .normal)
            rightBarButton.setTitleColor(.gray200, for: .highlighted)
            rightBarButton.titleLabel?.font = .kevinFont(type: .regular16)
            rightBarButton.titleLabel?.textAlignment = .center
        }
    }
}
