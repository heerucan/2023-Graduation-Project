//
//  WriteViewController.swift
//  Kevin
//
//  Created by heerucan on 2023/05/01.
//

import UIKit

import RxSwift
import RxCocoa
import SnapKit
import Then

final class WriteViewController: UIViewController {
    
    private let disposeBag = DisposeBag()
    private let viewModel: WriteViewModel
    
    private let loadingIndicator = UIActivityIndicatorView()
    private let naviBar = KevinNavigationBar(type: .write)
    private let dateLabel = UILabel().then {
        $0.font = .kevinFont(type: .medium14)
        $0.textColor = .black
        $0.textAlignment = .left
    }
    
    private let textView = UITextView().then {
        $0.font = .kevinFont(type: .regular16)
        $0.textColor = .gray200
        $0.textAlignment = .left
        $0.text = StringLiteral.placeholder
    }
    
    private let cardButton = KevinButton(type: .card)
    
    init(viewModel: WriteViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUI()
        setLayout()
        bind()
        hideKeyboardTappedAround()
    }
    
    private func bind() {
        let input = WriteViewModel.Input(
            analysisButtonTap: naviBar.rightBarButton.rx.tap,
            backButtonTap: naviBar.leftBarButton.rx.tap,
            textViewText: textView.rx.text
        )
        let output = viewModel.transform(input)
        
        output.dateText
            .bind(to: dateLabel.rx.text)
            .disposed(by: disposeBag)
        
        output.isValidText
            .drive(naviBar.rightBarButton.rx.isHighlighted)
            .disposed(by: disposeBag)
        
        output.isValidText
            .map { !$0 }
            .drive(naviBar.rightBarButton.rx.isEnabled)
            .disposed(by: disposeBag)
        
        output.isLoading
            .drive(loadingIndicator.rx.isAnimating)
            .disposed(by: disposeBag)
        
        textView.rx.didBeginEditing
            .subscribe { [weak self] _ in
                guard let self else { return }
                if self.textView.text == StringLiteral.placeholder {
                    self.textView.text = ""
                }
                self.textView.textColor = .black
            }
            .disposed(by: disposeBag)
        
        textView.rx.didEndEditing
            .subscribe { [weak self] _ in
                guard let self else { return }
                if self.textView.text.isEmpty {
                    self.textView.text = StringLiteral.placeholder
                    self.textView.textColor = .gray200
                }
            }
            .disposed(by: disposeBag)
        
        textView.rx.didEndDragging
            .subscribe { [weak self] _ in
                guard let self else { return }
                self.textView.resignFirstResponder()
            }
            .disposed(by: disposeBag)
    }
}

extension WriteViewController {
    private func setUI() {
        view.backgroundColor = .systemBackground
    }
    
    private func setLayout() {
        view.addSubviews([naviBar, dateLabel, textView, loadingIndicator])
        
        naviBar.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(49)
            make.directionalHorizontalEdges.equalToSuperview()
        }
        
        dateLabel.snp.makeConstraints { make in
            make.top.equalTo(naviBar.snp.bottom).offset(32)
            make.leading.equalToSuperview().inset(20)
        }
        
        textView.snp.makeConstraints { make in
            make.top.equalTo(dateLabel.snp.bottom).offset(10)
            make.leading.equalToSuperview().inset(14)
            make.trailing.equalToSuperview().inset(20)
            make.height.equalTo(350)
        }
        
        loadingIndicator.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
}
