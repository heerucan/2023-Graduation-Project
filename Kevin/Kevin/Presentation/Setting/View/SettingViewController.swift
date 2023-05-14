//
//  SettingViewController.swift
//  Kevin
//
//  Created by heerucan on 2023/05/01.
//

import UIKit

import RxSwift
import RxCocoa
import SnapKit
import Then

final class SettingViewController: UIViewController {
    
    private let disposeBag = DisposeBag()
    private let viewModel: SettingViewModel
    
    init(viewModel: SettingViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUI()
        bind()
    }
    
    private func bind() {
        
    }
}

extension SettingViewController {
    private func setUI() {
        view.backgroundColor = .yellow
    }
}
