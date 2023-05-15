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
            .subscribe { [weak self] _ in
                guard let self else { return }
                self.coordinator?.showAnalysisScreen(for: "")
            }
            .disposed(by: disposeBag)
        
        input.backButtonTap
            .subscribe { _ in
                self.coordinator?.finish()
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
        dateFormatter.dateFormat = "yyyy년 M월 d일"
        return dateFormatter.string(from: date)
    }
}
