//
//  DetailViewController.swift
//  Kevin
//
//  Created by heerucan on 2023/05/01.
//

import UIKit

import RxSwift
import RxCocoa
import SnapKit
import Then

final class DetailViewController: UIViewController {
    
    private let disposeBag = DisposeBag()
    private let viewModel: DetailViewModel
    
    private let naviBar = KevinNavigationBar()
    private let resultLabel = UILabel().then {
        $0.font = .kevinFont(type: .medium14)
        $0.textColor = .black
        $0.textAlignment = .left
        $0.numberOfLines = 0
    }
    
    init(viewModel: DetailViewModel) {
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
        let input = DetailViewModel.Input(
            backButtonTap: naviBar.leftBarButton.rx.tap
        )
        let output = viewModel.transform(input)
        
        output.detailData
            .subscribe(onNext: { [weak self] data in
                guard let self = self else { return }
                self.resultLabel.text = "사용자 감정 : \(data.emotionContent), \n\n감정분석 결과 : \(data.analysis) \n\n타입 : \(data.emotionType) \n\n감정분석 퍼센테이지 : 긍정 \(data.positive)%, 부정 \(data.negative)%, 중립 \(data.neutral)% \n\n날짜 : \(data.recordDate)"
            })
            .disposed(by: disposeBag)
    }
}

extension DetailViewController {
    private func setUI() {
        view.backgroundColor = .background
    }
    
    private func setLayout() {
        view.addSubviews([naviBar, resultLabel])
        
        naviBar.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(49)
            make.directionalHorizontalEdges.equalToSuperview()
        }
        
        resultLabel.snp.makeConstraints { make in
            make.top.equalTo(naviBar.snp.bottom).offset(32)
            make.directionalHorizontalEdges.equalToSuperview().inset(20)
        }
    }
}
