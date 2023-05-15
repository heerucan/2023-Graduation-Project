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
    private var cardSide: KevinCardSideType = .back
    
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
    
    private let backScrollView = UIScrollView().then {
        $0.backgroundColor = .clear
        $0.showsVerticalScrollIndicator = false
        $0.showsVerticalScrollIndicator = false
    }
    
    private let contentView = UIView().then {
        $0.backgroundColor = .clear
    }
    
    private let analysisLabel = UILabel().then {
        $0.font = .kevinFont(type: .regular16)
        $0.textAlignment = .left
        $0.numberOfLines = 0
        $0.textColor = .black
        $0.text = "네이버 감정분석API 결과에 따르면, 해당 문장 <오늘 옷을 사서 기분이 좋았어>는 거의 완전히 긍정적인 감정을 담고 있습니다. 긍정 비율이 99.9%로 매우 높고, 부정 비율은 0.03%로 아주 낮습니다. 중립 비율도 0.07%로 매우 낮기 때문에, 이 문장은 거의 완전히 긍정적인 감정을 나타내고 있다고 해석할 수 있습니다.\n\n당신이 기분 좋은 일을 경험했다는 것은 좋은 소식입니다. 이렇게 작은 일이네이버 감정분석API 결과에 따르면, 해당 문장 <오늘 옷을 사서 기분이 좋았어>는 거의 완전히 긍정적인 감정을 담고 있습니다. 긍정 비율이 99.9%로 매우 높고, 부정 비율은 0.03%로 아주 낮습니다. 중립 비율도 0.07%로 매우 낮기 때문에, 이 문장은 거의 완전히 긍정적인 감정을 나타내고 있다고 해석할 수 있습니다.\n\n당신이 기분 좋은 일을 경험했다는 것은 좋은 소식입니다. 이렇게 작은 일이"
    }
    
    init(type: AnalysisType, side: KevinCardSideType) {
        self.type = type
        self.cardSide = side
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
        analysisLabel.setLineSpacing()
    }
    
    private func setLayout() {
        self.addSubview(topView)
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
        
        cardSide == .front ? setFrontSideLayout() : setBackSideLayout()
    }
    
    private func setFrontSideLayout() {
        self.addSubviews([stickerImageView, percentageLabel])
        
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
    
    private func setBackSideLayout() {
        self.addSubview(backScrollView)
        backScrollView.addSubview(contentView)
        contentView.addSubview(analysisLabel)
        
        backScrollView.snp.makeConstraints { make in
            make.top.equalTo(topView.snp.bottom).offset(20)
            make.directionalHorizontalEdges.equalToSuperview().inset(25)
            make.bottom.equalToSuperview().inset(35)
        }
        
        contentView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
            make.width.equalTo(backScrollView.snp.width)
        }
        
        analysisLabel.snp.makeConstraints { make in
            make.edges.equalToSuperview()
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
