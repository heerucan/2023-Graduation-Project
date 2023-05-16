//
//  WriteViewModel.swift
//  Kevin
//
//  Created by heerucan on 2023/05/01.
//

import Foundation

import RxSwift
import RxCocoa

final class WriteViewModel: ViewModelType {
    
    weak var coordinator: MainCoordinator?
    private let disposeBag = DisposeBag()
    
    private let dateRelay = BehaviorRelay<Date?>(value: nil)
    private let textInvalidRelay = BehaviorRelay<Bool>(value: false)
    private let typeRelay = BehaviorRelay<AnalysisType>(value: .neutral)
    private let loadingRelay = BehaviorRelay<Bool>(value: false)
    
    private let chatResponse = PublishRelay<ChatResponseDTO>()
    private let naverResponse = PublishRelay<NaverResponseDTO>()
    private let networkError = PublishRelay<Error>()
    
    init(coordinator: MainCoordinator, date: Date?) {
        self.coordinator = coordinator
        self.dateRelay.accept(date)
    }
    
    struct Input {
        let analysisButtonTap: ControlEvent<Void>
        let backButtonTap: ControlEvent<Void>
        let textViewText: ControlProperty<String?>
    }
    
    struct Output {
        let dateText: Observable<String>
        let isValidText: Driver<Bool>
        let isLoading: Driver<Bool>
    }
    
    func transform(_ input: Input) -> Output {
                
        input.analysisButtonTap
            .withLatestFrom(input.textViewText.orEmpty)
            .throttle(.milliseconds(500), latest: false, scheduler: MainScheduler.instance)
            .subscribe { [weak self] text in
                guard let self else { return }
                self.loadingRelay.accept(true)
                self.requestNaverAnalysis(text: text)
            }
            .disposed(by: disposeBag)
        
        input.backButtonTap
            .subscribe { [weak self] _ in
                guard let self else { return }
                self.coordinator?.showAlert(
                    title: StringLiteral.Alert.title,
                    message: StringLiteral.Alert.message
                )
            }
            .disposed(by: disposeBag)
        
        let date = dateRelay
            .map { date -> String in
                DateFormatterUtil.formateDate(date)
            }
                
        let isValidText = input.textViewText
            .orEmpty
            .map { value in
                (value == StringLiteral.placeholder) ||
                (value.trimmingCharacters(in: .whitespacesAndNewlines) == "")
            }
            .asDriver(onErrorJustReturn: false)
        
        let isLoading = loadingRelay.asDriver(onErrorJustReturn: false)
                
        return Output(
            dateText: date,
            isValidText: isValidText,
            isLoading: isLoading
        )
    }
}

extension WriteViewModel {
    
    private func requestNaverAnalysis(text: String) {
        NaverService.shared.requestNaverAnalysis(text: text)
            .subscribe(onNext: { [weak self] response in
                guard let self else { return }
                let type = AnalysisType(rawValue: response.document.sentiment) ?? .neutral
                
                self.naverResponse.accept(response)
                self.typeRelay.accept(type)
                
                // TODO: - 챗지피티한테 보낼 것은 다듬어서 전달
//                let content =
                self.requestChatGPT(content: "행복한 하루였어")
                
            }, onError: { error in
                self.networkError.accept(error)
                self.loadingRelay.accept(false)
            })
            .disposed(by: disposeBag)
    }
    
    private func requestChatGPT(content: String) {
        ChatService.shared.requestChat(content: content)
            .subscribe(onNext: { [weak self] response in
                guard let self else { return }
                let type = AnalysisType(rawValue: self.typeRelay.value.rawValue) ?? .neutral

                // TODO: - 네이버 응답결과 퍼센테이지도 전달해야함
//                self.naverResponse.values
                
                self.chatResponse.accept(response)
                self.loadingRelay.accept(false)
                self.coordinator?.showAnalysisScreen(for: response.resultText, type: type)
                
            }, onError: { error in
                self.networkError.accept(error)
                self.loadingRelay.accept(false)
            })
            .disposed(by: disposeBag)
    }
}
