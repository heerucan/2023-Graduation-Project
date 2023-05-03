//
//  KevinCardView.swift
//  Kevin
//
//  Created by heerucan on 2023/04/30.
//

import UIKit

import SnapKit
import Then

final class KevinCardView: UIView {
    
    private var type: AnalysisType = .positive
    private var date: String = "오늘의 감정" {
        didSet {
            topLabel.text = date + "의 감정"
        }
    }
    
    private let topView = UIView().then {
        $0.makeCorner(width: 0, radius: 18)
        $0.backgroundColor = .green200
    }
    
    private let topLabel = UILabel().then {
        $0.text = "4월 22일의 감정"
        $0.textColor = .white
        $0.font = .kevinFont(type: .semibold15)
        $0.textAlignment = .center
    }
    
    // TODO: - 분기처리 해야 함 - 앞인지 뒤인지
    private let stickerImageView = UIImageView().then {
        $0.image = Image.green
        $0.contentMode = .scaleAspectFill
    }
    
    private let percentageLabel = UILabel().then {
        $0.text = "긍정 98% 부정 2%"
        $0.textColor = .black
        $0.font = .kevinFont(type: .medium18)
        $0.textAlignment = .center
        $0.numberOfLines = 1
    }
    
    init(type: AnalysisType) {
        self.type = type
        super.init(frame: .zero)
        setUI()
        setLayout()
        setAnimation()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setUI() {
        self.makeCorner()
        self.layer.applyShadow()
        self.backgroundColor = .white.withAlphaComponent(0.5)
        topView.backgroundColor = type.color
        stickerImageView.image = type.sticker
    }
    
    private func setLayout() {
        self.addSubviews([topView, stickerImageView, percentageLabel])
        topView.addSubview(topLabel)
        
        topView.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(35)
            make.centerX.equalToSuperview()
            make.height.equalTo(36)
        }
        
        topLabel.snp.makeConstraints { make in
            make.center.equalToSuperview()
            make.directionalVerticalEdges.equalToSuperview().inset(5)
            make.directionalHorizontalEdges.equalToSuperview().inset(19)
        }
        
        stickerImageView.snp.makeConstraints { make in
            make.top.equalTo(topView.snp.bottom).offset(45)
            make.centerX.equalToSuperview()
            make.width.height.equalTo(MatrixLiteral.bigSticker)
        }
        
        percentageLabel.snp.makeConstraints { make in
            make.top.equalTo(stickerImageView.snp.bottom).offset(45)
            make.centerX.equalToSuperview()
        }
    }
    
    private func setAnimation() {
        let animation = CAKeyframeAnimation(keyPath: "transform.translation.y")
        animation.values = [0, 2.5, 0]
        animation.keyTimes = [0, 0.5, 1]
        animation.duration = 1.0
        animation.repeatCount = .infinity
        self.layer.add(animation, forKey: "updown")
    }
}
