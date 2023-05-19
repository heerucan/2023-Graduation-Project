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
    
    private var cardSide: KevinCardSideType = .back
    
    var type: AnalysisType = .positive {
        didSet {
            topView.backgroundColor = type.color
            stickerImageView.image = type.sticker
        }
    }
    
    var date: String = "오늘의 감정" {
        didSet {
            topLabel.text = date.prefix(7).suffix(2) + "월 " + date.suffix(2) + "일의 감정"
        }
    }
    
    var percentage: Confidence = Confidence(neutral: 0, positive: 0, negative: 0) {
        didSet {
            percentageLabel.text = doubleToString(percentage)
        }
    }
    
    private let topView = UIView().then {
        $0.makeCorner(width: 0, radius: 18)
        $0.backgroundColor = .green200
    }
    
    private let topLabel = UILabel().then {
        $0.textColor = .white
        $0.font = .kevinFont(type: .semibold15)
        $0.textAlignment = .center
    }
    
    private let stickerImageView = UIImageView().then {
        $0.image = Image.positive
        $0.contentMode = .scaleAspectFill
    }
    
    private let percentageLabel = UILabel().then {
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
    
    let analysisLabel = UILabel().then {
        $0.font = .kevinFont(type: .regular16)
        $0.textAlignment = .left
        $0.numberOfLines = 0
        $0.textColor = .black
    }
    
    init(side: KevinCardSideType) {
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
    
    private func doubleToString(_ percentage: Confidence) -> String {
        let confidence = [percentage.positive, percentage.negative, percentage.neutral]
        let index = confidence.firstIndex(of: confidence.max()!)
        let emotion = round(confidence.max()!*100)/100
        var emotionKor = ""
        switch index {
        case 0:
            emotionKor = "긍정"
        case 1:
            emotionKor = "부정"
        default:
            emotionKor = "중립"
        }
        return emotionKor + "적인 감정, \(emotion)%"
    }
}
