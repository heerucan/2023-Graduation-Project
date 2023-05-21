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
    private let loadingRelay = BehaviorRelay<Bool>(value: false)
    private let typeRelay = BehaviorRelay<AnalysisType>(value: .neutral)
    private let percentageRelay = BehaviorRelay<Confidence?>(value: nil)
    private let viewTypeRelay = BehaviorRelay<NavigationType>(value: .write)

    private let networkError = PublishRelay<Error>()
        
    init(coordinator: MainCoordinator,
         date: Date?,
         type: NavigationType
    ) {
        self.coordinator = coordinator
        self.dateRelay.accept(date)
        self.viewTypeRelay.accept(type)
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
        let viewType: Observable<NavigationType>
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
                DateFormatterUtil.format(date, .fullKor)
            }
                
        let isValidText = input.textViewText
            .orEmpty
            .map { value in
                (value == StringLiteral.placeholder) ||
                (value.trimmingCharacters(in: .whitespacesAndNewlines) == "")
            }
            .asDriver(onErrorJustReturn: false)
        
        input.textViewText
            .orEmpty
            .asObservable()
            .subscribe(onNext: { text in
                guard !text.isEmpty else { return }
                UserDefaults.standard.setValue(text, forKey: "UserEmotionRecord")
            })
            .disposed(by: disposeBag)
        
        let isLoading = loadingRelay.asDriver(onErrorJustReturn: false)
        
        let viewType = viewTypeRelay
            .map { $0 }
                        
        return Output(
            dateText: date,
            isValidText: isValidText,
            isLoading: isLoading,
            viewType: viewType
        )
    }
}

extension WriteViewModel {
    private func requestNaverAnalysis(text: String) {
        NaverService.shared.requestNaverAnalysis(text: text)
            .subscribe(onNext: { [weak self] response in
                guard let self = self else { return }
                let type = AnalysisType(rawValue: response.document.sentiment) ?? .neutral
                let content = "나의 오늘 하루 기록은 \(text)와 같고, \(text)에 대한 감정분석 결과, \(response.document.sentiment)이고, 긍정비율은 \(response.document.confidence.positive), 부정비율은 \(response.document.confidence.negative), 중립비율은 \(response.document.confidence.neutral)이야. 이에 대해 너가 감정분석 결과 퍼센테이지와 최종 감정분석을 말해주고, 감정에 대해 객관적인 응원이나 격려 또는 조언의 말을 친구한테 말하듯이 말해줘."
                
                self.typeRelay.accept(type)
                self.percentageRelay.accept(response.document.confidence)
                self.requestChatGPT(content: content)
                
            }, onError: { error in
                self.networkError.accept(error)
                self.loadingRelay.accept(false)
            })
            .disposed(by: disposeBag)
    }
    
    private func requestChatGPT(content: String) {
        ChatService.shared.requestChat(content: content)
            .subscribe(onNext: { [weak self] response in
                guard let self = self else { return }
                self.loadingRelay.accept(false)
                let data = ResultModel(
                    percentage: self.percentageRelay.value,
                    type: self.typeRelay.value,
                    date: DateFormatterUtil.format(self.dateRelay.value),
                    content: response.resultText
                )
                self.coordinator?.showAnalysisScreen(data: data)
                
            }, onError: { error in
                self.networkError.accept(error)
                self.loadingRelay.accept(false)
            })
            .disposed(by: disposeBag)
    }
}
