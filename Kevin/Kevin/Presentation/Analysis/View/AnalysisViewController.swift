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
    
    private var type: AnalysisType!
    
    private let naviBar = KevinNavigationBar(type: .analysis)
    private let backView = UIImageView()
    private let anoterButton = UIButton()
    private let cardView = KevinCardView(type: .neutral)
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
    
    private func bind() {
        
    }
}

extension AnalysisViewController {
    private func setUI() {
        view.backgroundColor = .systemBackground
        backView.contentMode = .scaleAspectFill
        type = .neutral
        backView.image = type.back
        resultButton.backgroundColor = type.color
    }
    
    private func setLayout() {
        view.addSubviews([backView, naviBar, anoterButton, cardView, shareButton, resultButton])
        
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
            make.height.equalTo(MatrixLiteral.buttonSize)
        }
        
        cardView.snp.makeConstraints { make in
            make.top.equalTo(anoterButton.snp.bottom).offset(15)
            make.directionalHorizontalEdges.equalToSuperview().inset(38)
            make.height.equalTo(455)
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
