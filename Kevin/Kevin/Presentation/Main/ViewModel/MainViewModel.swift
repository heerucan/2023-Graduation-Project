//
//  MainViewModel.swift
//  Kevin
//
//  Created by heerucan on 2023/05/01.
//

import Foundation

import RxSwift
import RxCocoa

final class MainViewModel: ViewModelType {
    
    weak var coordinator: MainCoordinator?
    private let disposeBag = DisposeBag()
    
    private let calendarRelay = BehaviorRelay<[CalendarResponse]?>(value: nil)
    private var dateEmotiondict: [String:Int] = [:]
        
    init(coordinator: MainCoordinator) {
        self.coordinator = coordinator
    }
    
    struct Input {
        let viewWillAppear: Signal<Void>
        let todayDate: Observable<Date?>
        let settingButtonDidTap: ControlEvent<Void>
        let calendarDidSelected: Observable<Date>
    }
    
    struct Output {
    }
    
    func transform(_ input: Input) -> Output {
        
        input.viewWillAppear
            .emit { [weak self] _ in
                guard let self = self else { return }
                self.subscribeToday(input.todayDate)
            }
            .disposed(by: disposeBag)
        
        let selectedDate = PublishSubject<Date>()
        
        input.settingButtonDidTap
            .subscribe { [weak self] _ in
                guard let self = self else { return }
                self.coordinator?.showSettingFlow()
            }
            .disposed(by: disposeBag)
        
        input.calendarDidSelected
            .subscribe(onNext: { [weak self] date in
                guard let self = self else { return }
                let slashDate = DateFormatterUtil.format(date, .fullSlash)
                self.requestDetail(date: date, emotionId: dateEmotiondict[slashDate] ?? 0)
                selectedDate.onNext(date)
            })
            .disposed(by: disposeBag)
        
        return Output()
    }
}

extension MainViewModel {
    private func subscribeToday(_ todayDate: Observable<Date?>) {
        todayDate
            .take(1)
            .compactMap { $0 }
            .map { DateFormatterUtil.format($0, .fullSlash) }
            .subscribe { [weak self] date in
                guard let self = self else { return }
                self.requestCalendar(date: date)
            }
            .disposed(by: disposeBag)
    }
    
    private func matchingDateAndId() {
        calendarRelay.value?.forEach {
            dateEmotiondict.updateValue($0.emotionID, forKey: $0.recordDate)
        }
    }
    
    private func requestCalendar(date: String) {
        EmotionService.shared.requestCalendar(date: date)
            .subscribe(onNext: { [weak self] response in
                guard let self = self else { return }
                switch response.code {
                case 200:
                    // TODO: - 데이터 세팅
                    self.calendarRelay.accept(response.data)
                    self.matchingDateAndId()
                    
                default:
                    // TODO: - networkError 처리
                    print(response.code)
                }
            }, onError: { error in
                print(error.localizedDescription)
//                self.networkError.accept(error)
            })
            .disposed(by: disposeBag)
    }
    
    private func requestDetail(date: Date, emotionId: Int) {
        EmotionService.shared.requestDetail(emotionId: emotionId)
            .subscribe(onNext: { [weak self] response in
                guard let self = self else { return }
                guard let data = response.data else { return }
                switch response.code {
                case 200:
                    self.coordinator?.showDetailScreen(data: data, type: .detail)
                case 404:
                    self.coordinator?.showWriteScreen(date: date, type: .write)
                default:
                    // TODO: - networkError 처리
                    print(response.code)
                }
            }, onError: { error in
                print(error.localizedDescription)
//                self.networkError.accept(error)
            })
            .disposed(by: disposeBag)
    }
}
