//
//  MainViewController.swift
//  Kevin
//
//  Created by heerucan on 2023/05/01.
//

import UIKit

import RxSwift
import RxCocoa
import SnapKit
import Then

final class MainViewController: UIViewController {
    
    private let disposeBag = DisposeBag()
    private let viewModel: MainViewModel
    
    init(viewModel: MainViewModel) {
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

extension MainViewController {
    private func setUI() {
        view.backgroundColor = .pink100
    }
    
    private func setLayout() {
        
    }
}
