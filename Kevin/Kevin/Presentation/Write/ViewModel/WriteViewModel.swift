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
    
    private let dateSubject = BehaviorSubject<Date?>(value: nil).asObserver()
    private let textViewInvalid = BehaviorSubject<Bool>(value: false)
    private let typeRelay = BehaviorRelay<AnalysisType>(value: .neutral)
    private var chatResponse = PublishSubject<ChatResponseDTO>()
    private var naverResponse = PublishSubject<NaverResponseDTO>()
    private var chatFail = PublishSubject<Error>()
    
        
    init(coordinator: MainCoordinator, date: Date?) {
        self.coordinator = coordinator
        self.dateSubject.onNext(date)
    }
    
    struct Input {
        let analysisButtonTap: ControlEvent<Void>
        let backButtonTap: ControlEvent<Void>
        let textViewText: ControlProperty<String?>
        let textDidBeginEditing: ControlEvent<()>
        let textDidEndEditing: ControlEvent<()>
        let textDidEndDragging: ControlEvent<()>
    }
    
    struct Output {
        let dateLabelText: Observable<String>
        let textViewIsValid: Observable<Bool>
        let didBeginEditing: ControlEvent<()>
        let didEndEditing: ControlEvent<()>
        let didEndDragging: ControlEvent<()>
    }
    
    func transform(_ input: Input) -> Output {
        
        input.analysisButtonTap
            .withLatestFrom(input.textViewText.orEmpty)
            .throttle(.milliseconds(500), latest: false, scheduler: MainScheduler.instance)
            .subscribe { [weak self] text in
                guard let self else { return }
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
        
        let date = dateSubject
            .map { date -> String in
                self.changeDateFormatter(date)
            }
                
        let textViewIsValid = input.textViewText
            .orEmpty
            .map { value in
                (value == StringLiteral.placeholder) ||
                (value.trimmingCharacters(in: .whitespacesAndNewlines) == "")
                ? true : false
            }
        
        let didBeginEditing = input.textDidBeginEditing
        let didEndEditing = input.textDidEndEditing
        let didEndDragging = input.textDidEndDragging
                
        return Output(
            dateLabelText: date,
            textViewIsValid: textViewIsValid,
            didBeginEditing: didBeginEditing,
            didEndEditing: didEndEditing,
            didEndDragging: didEndDragging
        )
    }
}

extension WriteViewModel {
    private func changeDateFormatter(_ date: Date?) -> String {
        guard let date = date else { return "" }
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = StringLiteral.Calendar.fullDateFormat
        return dateFormatter.string(from: date)
    }
    
    private func requestNaverAnalysis(text: String) {
        NaverService.shared.requestNaverAnalysis(text: text)
            .subscribe(onNext: { [weak self] response in
                guard let self else { return }
                let type = AnalysisType(rawValue: response.document.sentiment) ?? .neutral
                
                self.naverResponse.onNext(response)
                self.typeRelay.accept(type)
                
                // TODO: - 챗지피티한테 보낼 것은 다듬어서 전달
//                let content =
                self.requestChatGPT(content: "행복한 하루였어")
                
            }, onError: { error in
                // TODO: - 에러 처리
                print(error.localizedDescription)
            })
            .disposed(by: disposeBag)
    }
    
    private func requestChatGPT(content: String) {
        ChatService.shared.requestChat(content: content)
            .subscribe(onNext: { [weak self] response in
                guard let self else { return }
                let type = AnalysisType(rawValue: typeRelay.value.rawValue) ?? .neutral
                
                // TODO: - 네이버 응답결과 퍼센테이지도 전달해야함
//                self.naverResponse.values
                
                self.chatResponse.onNext(response)
                self.coordinator?.showAnalysisScreen(
                    for: response.resultText,
                    type: type)
                                
            }, onError: { error in
                // TODO: - 에러 처리
                print(error.localizedDescription)
                self.chatFail.onNext(error)
            })
            .disposed(by: disposeBag)
    }
}
