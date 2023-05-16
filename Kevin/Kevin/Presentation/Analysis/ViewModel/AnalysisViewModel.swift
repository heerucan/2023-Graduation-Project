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
    private let chatUseCase: ChatUseCase
    private let naverUseCase: NaverUseCase
    
    init(coordinator: MainCoordinator,
         chatUseCase: ChatUseCase,
         naverUseCase: NaverUseCase,
         type: AnalysisType,
         content: String
    ) {
        self.coordinator = coordinator
        self.chatUseCase = chatUseCase
        self.naverUseCase = naverUseCase
        self.type = type
        self.content = content
    }
    
    struct Input {
        let backButtonTap: ControlEvent<Void>
        let comfirmButtonTap: ControlEvent<Void>
        let resultButtonTap: ControlEvent<Void>
    }
    
    struct Output {
        let resultButtonTap: ControlEvent<Void>
        let analysisText: Observable<String>
    }
    
    let type: AnalysisType
    let resultContent = PublishSubject<String>()
    let content: String
    
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
        
        resultContent.onNext(content)
                            
        return Output(
            resultButtonTap: input.resultButtonTap,
            analysisText: resultContent.asObservable()
        )
    }
}
