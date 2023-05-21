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
    private let networkError = PublishRelay<Error>()
    
    init(coordinator: MainCoordinator,
         data: ResultModel
    ) {
        self.coordinator = coordinator
        self.dataRelay.accept(data)
    }
    
    struct Input {
        let backButtonTap: ControlEvent<Void>
        let confirmButtonTap: ControlEvent<Void>
        let resultButtonTap: ControlEvent<Void>
    }
    
    struct Output {
        let resultButtonTap: ControlEvent<Void>
        let resultData: Observable<ResultModel?>
    }
    
    func transform(_ input: Input) -> Output {
        
        input.backButtonTap
            .subscribe { [weak self] _ in
                guard let self = self else { return }
                self.coordinator?.finish()
            }
            .disposed(by: disposeBag)
        
        let emotionRequest = dataRelay
            .compactMap { $0 }
            .map { data -> EmotionRequest in
                var emotionContent = ""
                if let text = UserDefaults.standard.string(forKey: "UserEmotionRecord") {
                    emotionContent = text
                } else {
                    emotionContent = ""
                }
                
                let request = EmotionRequest(
                    recordDate: data.date,
                    emotionContent: emotionContent,
                    positive: Int(data.percentage!.positive),
                    negative: Int(data.percentage!.negative),
                    neutral: Int(data.percentage!.neutral),
                    analysis: data.content,
                    emotionType: data.type.rawValue
                )
                return request
            }
            
        input.confirmButtonTap
            .throttle(.milliseconds(500), scheduler: MainScheduler.instance)
            .withLatestFrom(emotionRequest)
            .bind { [weak self] request in
                guard let self = self else { return }
                print(request, "요청")
                self.requestWrite(request: request)
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

extension AnalysisViewModel {
    private func requestWrite(request: EmotionRequest) {
        EmotionService.shared.requestWrite(request: request)
            .subscribe(onNext: { [weak self] response in
                guard let self = self else { return }
                print("글작성 요청", response)
                switch response.code {
                case 201:
                    self.coordinator?.popRootViewController()
                default:
                    // TODO: - networkError 처리
                    print(response.code)
                }
            }, onError: { error in
                print(error.localizedDescription)
                self.networkError.accept(error)
            })
            .disposed(by: disposeBag)
    }
}
