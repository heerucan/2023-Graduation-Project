//
//  AnalysisViewModel.swift
//  Kevin
//
//  Created by heerucan on 2023/05/01.
//

import Foundation

import RxSwift
import RxCocoa

final class AnalysisViewModel: ViewModelType {
    
    weak var coordinator: MainCoordinator?
    private let disposeBag = DisposeBag()
    
    let type: AnalysisType
    private let contentRelay = BehaviorRelay<String>(value: "")
    
    init(coordinator: MainCoordinator,
         type: AnalysisType,
         content: String
    ) {
        self.coordinator = coordinator
        self.type = type
        self.contentRelay.accept(content)
    }
    
    struct Input {
        let backButtonTap: ControlEvent<Void>
        let comfirmButtonTap: ControlEvent<Void>
        let resultButtonTap: ControlEvent<Void>
    }
    
    struct Output {
        let resultButtonTap: ControlEvent<Void>
//        let percentageText: BehaviorRelay<String>
        let analysisText: BehaviorRelay<String>
    }
    
    func transform(_ input: Input) -> Output {
        input.backButtonTap
            .subscribe { [weak self] _ in
                guard let self else { return }
                self.coordinator?.finish()
            }
            .disposed(by: disposeBag)
        
        input.comfirmButtonTap
            .throttle(.milliseconds(500), scheduler: MainScheduler.instance)
            .subscribe { [weak self] _ in
                guard let self else { return }
                self.coordinator?.popRootViewController()
            }
            .disposed(by: disposeBag)
        
        let resultButtonTap = input.resultButtonTap
        let analysisText = contentRelay
        
        print("분석뷰모델 gpt 응답 ->> ", contentRelay.value)
                    
        return Output(
            resultButtonTap: resultButtonTap,
//            percentageText: <#T##BehaviorRelay<String>#>,
            analysisText: analysisText
        )
    }
}
