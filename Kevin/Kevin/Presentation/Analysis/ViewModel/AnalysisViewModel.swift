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
    
    private let dataRelay = BehaviorRelay<ResultModel?>(value: nil)
    
    init(coordinator: MainCoordinator,
         data: ResultModel
    ) {
        self.coordinator = coordinator
        self.dataRelay.accept(data)
    }
    
    struct Input {
        let backButtonTap: ControlEvent<Void>
        let comfirmButtonTap: ControlEvent<Void>
        let resultButtonTap: ControlEvent<Void>
    }
    
    struct Output {
        let resultButtonTap: ControlEvent<Void>
        let resultData: Observable<ResultModel?>
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
                self.coordinator?.popRootViewController(
                    date: dataRelay.value!.date,
                    type: AnalysisType(rawValue: dataRelay.value!.type.rawValue) ?? .negative
                )
            }
            .disposed(by: disposeBag)
        
        let resultButtonTap = input.resultButtonTap
        
        let resultData = Observable.just(dataRelay.value).asObservable().share()
                                    
        return Output(
            resultButtonTap: resultButtonTap,
            resultData: resultData
        )
    }
}
