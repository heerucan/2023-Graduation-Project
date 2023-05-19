//
//  AnalysisViewController.swift
//  Kevin
//
//  Created by heerucan on 2023/05/01.
//

import UIKit

import RxSwift
import RxCocoa
import SnapKit
import Then

final class AnalysisViewController: UIViewController {
    
    private let disposeBag = DisposeBag()
    private let viewModel: AnalysisViewModel
        
    private lazy var backView = UIImageView()
    private let naviBar = KevinNavigationBar(type: .analysis)
    private let anoterButton = KevinImageButton()
    private let tapGesture = UITapGestureRecognizer()
    private let cardView = UIView()
    private lazy var cardFrontView = KevinCardView(type: viewModel.type, side: .front)
    private lazy var cardBackView = KevinCardView(type: viewModel.type, side: .back)
    private let shareButton = KevinButton(type: .share)
    private let resultButton = KevinButton(type: .result)
    
    init(viewModel: AnalysisViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUI()
        setLayout()
        bind()
    }
    
    private var isOpen = true
    
    private func bind() {
        let input = AnalysisViewModel.Input(
            backButtonTap: naviBar.leftBarButton.rx.tap,
            comfirmButtonTap: naviBar.rightBarButton.rx.tap,
            resultButtonTap: resultButton.rx.tap
        )
        let output = viewModel.transform(input)
        
        output.resultButtonTap
            .subscribe(onNext: { [weak self] _ in
                guard let self = self else { return }
                self.cardBackView.isHidden = false
                self.setFlipAnimation(self.isOpen)
                self.makeVibrate()
            })
            .disposed(by: disposeBag)
        
        output.resultData
            .compactMap { $0 }
            .map { $0.date }
            .bind(onNext: { [weak self] date in
                guard let self = self else { return }
                self.cardFrontView.date = date
                self.cardBackView.date = date
            })
            .disposed(by: disposeBag)
        
        output.resultData
            .compactMap { $0 }
            .map { $0.content }
            .bind(to: cardBackView.analysisLabel.rx.text)
            .disposed(by: disposeBag)
        
        output.resultData
            .compactMap { $0?.percentage }
            .bind { [weak self] percentage in
                guard let self = self else { return }
                self.cardFrontView.percentage = percentage
            }
            .disposed(by: disposeBag)
                        
        tapGesture.rx.event
            .bind { [weak self] _ in
                guard let self = self else { return }
                self.setEmitterLayer()
                self.cardView.makeVibrate()
            }
            .disposed(by: disposeBag)        
    }
}

extension AnalysisViewController {
    private func setFlipAnimation(_ side: Bool) {
        isOpen = !side
        let fromView = side ? cardFrontView : cardBackView
        let toView = side ? cardBackView : cardFrontView
        let option: UIView.AnimationOptions = side ? .transitionFlipFromRight : .transitionFlipFromLeft
        UIView.transition(from: fromView,
                          to: toView,
                          duration: 0.4,
                          options: [option, .showHideTransitionViews],
                          completion: nil)
    }
    
    private func setEmitterLayer() {
        let emitterLayer = CAEmitterLayer()
        emitterLayer.emitterPosition = CGPoint(
            x: tapGesture.location(in: view).x,
            y: tapGesture.location(in: view).y
        )
        
        let cell = CAEmitterCell()
        cell.birthRate = 10 // 파티클 개수
        cell.lifetime = 3 // 파티클 수명
        cell.lifetimeRange = 2
        cell.velocity = 700 // 속도, 높을수록 더 멀리, 빠르게 방출
        cell.velocityRange = 50
        cell.emissionRange = .pi*2 // 2pi는 360도 모든 방향으로 방출
        cell.spin = 3 // 회전효과 속도, 0은 회전없음
        cell.spinRange = 5
        cell.scale = 0.1 // 원래크기의 1/10을 곱함
        cell.scaleRange = 0.03 // 크기 범주
        cell.yAcceleration = 1400 // 양수는 중력적용, 음수는 위로 날아감, 값만큼 위로 올라가다가 내려감
        cell.contents = viewModel.type.sticker?.cgImage
        
        emitterLayer.emitterCells = [cell]
        view.layer.addSublayer(emitterLayer)
        
        DispatchQueue.main.asyncAfter(deadline: .now()+0.5) {
            emitterLayer.birthRate = 0
        }
    }
}

extension AnalysisViewController {
    private func setUI() {
        view.backgroundColor = .systemBackground
        backView.contentMode = .scaleAspectFill
        backView.image = viewModel.type.back
        resultButton.backgroundColor = viewModel.type.color
        cardBackView.isHidden = true
        cardView.addGestureRecognizer(tapGesture)
    }
    
    private func setLayout() {
        view.addSubviews([backView, naviBar, anoterButton, cardView, shareButton, resultButton])
        cardView.addSubviews([cardFrontView, cardBackView])
        
        backView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        naviBar.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(49)
            make.directionalHorizontalEdges.equalToSuperview()
        }
        
        anoterButton.snp.makeConstraints { make in
            make.top.equalTo(naviBar.snp.bottom).offset(5)
            make.centerX.equalToSuperview()
        }
        
        cardView.snp.makeConstraints { make in
            make.top.equalTo(anoterButton.snp.bottom).offset(15)
            make.directionalHorizontalEdges.equalToSuperview().inset(38)
            make.height.equalTo(455)
        }
        
        cardFrontView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        cardBackView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        shareButton.snp.makeConstraints { make in
            make.top.equalTo(cardView.snp.bottom).offset(47)
            make.leading.equalTo(cardView.snp.leading)
        }
        
        resultButton.snp.makeConstraints { make in
            make.top.equalTo(cardView.snp.bottom).offset(47)
            make.trailing.equalTo(cardView.snp.trailing)
        }
    }
}
