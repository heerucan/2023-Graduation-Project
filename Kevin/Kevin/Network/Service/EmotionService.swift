//
//  EmotionService.swift
//  Kevin
//
//  Created by heerucan on 2023/05/20.
//

import Foundation

import Moya
import RxMoya
import RxSwift

final class EmotionService {
    static let shared = EmotionService()
    private init() { }
    private let provider = MoyaProvider<EmotionAPI>()
    private let disposeBag = DisposeBag()

    /// GET 전체 캘린더
    func requestCalendar(date: String) -> Observable<GenericResponse<[CalendarResponse]>> {
        return Observable<GenericResponse<[CalendarResponse]>>.create { observer in
            self.provider.rx.request(.all(date: date))
                .subscribe { event in
                    switch event {
                    case .success(let response):
                        do {
                            let body = try response.map(GenericResponse<[CalendarResponse]>.self)
                            observer.onNext(body)
                            observer.onCompleted()
                        } catch let error {
                            observer.onError(error)
                        }
                    case .failure(let error):
                        observer.onError(error)
                    }
                }
                .disposed(by: self.disposeBag)
            return Disposables.create()
        }
    }
    
    /// GET 디테일
    func requestDetail(emotionId: Int) -> Observable<GenericResponse<DetailResponse>> {
        return Observable<GenericResponse<DetailResponse>>.create { observer in
            self.provider.rx.request(.detail(emotionId: emotionId))
                .subscribe { event in
                    switch event {
                    case .success(let response):
                        do {
                            let body = try response.map(GenericResponse<DetailResponse>.self)
                            observer.onNext(body)
                            observer.onCompleted()
                        } catch let error {
                            observer.onError(error)
                        }
                    case .failure(let error):
                        observer.onError(error)
                    }
                }
                .disposed(by: self.disposeBag)
            return Disposables.create()
        }
    }
    
    /// POST 감정기록
    func requestWrite(request: EmotionRequest) -> Observable<GenericResponse<VoidData>> {
        return Observable<GenericResponse<VoidData>>.create { observer in
            self.provider.rx.request(.write(request))
                .subscribe { event in
                    switch event {
                    case .success(let response):
                        do {
                            let body = try response.map(GenericResponse<VoidData>.self)
                            observer.onNext(body)
                            observer.onCompleted()
                        } catch let error {
                            observer.onError(error)
                        }
                    case .failure(let error):
                        observer.onError(error)
                    }
                }
                .disposed(by: self.disposeBag)
            return Disposables.create()
        }
    }
}
