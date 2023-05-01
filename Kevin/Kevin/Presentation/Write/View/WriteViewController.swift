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
    
    private let naviBar = KevinNavigationBar(type: .write)
    private let dateLabel = UILabel().then {
        $0.text = "2022년 4월 22일"
        $0.font = .kevinFont(type: .medium14)
        $0.textColor = .black
        $0.textAlignment = .left
    }
    
    private let textView = UITextView().then {
        $0.font = .kevinFont(type: .regular16)
        $0.textColor = .black
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
    }
    
    private func bind() {
        
    }
}

extension WriteViewController {
    private func setUI() {
        view.backgroundColor = .systemBackground
    }
    
    private func setLayout() {
        view.addSubviews([naviBar, dateLabel, textView, cardButton])
        
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
            make.height.equalTo(450)
        }
        
        cardButton.snp.makeConstraints { make in
            make.bottom.equalToSuperview().inset(105)
            make.centerX.equalToSuperview()
        }
    }
}
