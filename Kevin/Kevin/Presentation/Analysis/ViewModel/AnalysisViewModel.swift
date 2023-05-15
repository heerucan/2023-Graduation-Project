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
    
    init(coordinator: MainCoordinator, type: AnalysisType) {
        self.coordinator = coordinator
        self.type = type
    }
    
    struct Input {
        let backButtonTap: ControlEvent<Void>
        let comfirmButtonTap: ControlEvent<Void>
        let resultButtonTap: ControlEvent<Void>
    }
    
    struct Output {
        let resultButtonTap: ControlEvent<Void>
    }
    
    let type: AnalysisType
    
    func transform(_ input: Input) -> Output {
        input.backButtonTap
            .subscribe { [weak self] _ in
                guard let self else { return }
                self.coordinator?.finish()
            }
            .disposed(by: disposeBag)
        
        input.comfirmButtonTap
            .subscribe { [weak self] _ in
                guard let self else { return }
                self.coordinator?.popRootViewController()
            }
            .disposed(by: disposeBag)
        
        let resultButtonTap = input.resultButtonTap
                    
        return Output(
            resultButtonTap: resultButtonTap
        )
    }
}
