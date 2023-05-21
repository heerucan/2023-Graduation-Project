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
    
    private let naviBar = KevinNavigationBar()
    private let tableView = UITableView().then {
        $0.backgroundColor = .background
        $0.separatorStyle = .none
    }
    
    private let imageView = UIImageView().then {
        $0.image = Image.colors
    }
    
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
        setLayout()
        setTableView()
        bind()
    }
    
    private func bind() {
        let input = SettingViewModel.Input(
            backButtonTap: naviBar.leftBarButton.rx.tap,
            itemSelected: tableView.rx.itemSelected
        )
        let output = viewModel.transform(input)
        
        output.settingList
            .bind(to: tableView.rx.items(
                cellIdentifier: SettingTableViewCell.className,
                cellType: SettingTableViewCell.self)
            ) { index, model, cell in
                cell.menuLabel.text = model.rawValue
            }
            .disposed(by: disposeBag)
    }
}

extension SettingViewController {
    private func setUI() {
        view.backgroundColor = .background
        naviBar.type = .setting
    }
    
    private func setLayout() {
        view.addSubviews([naviBar, tableView, imageView])
        
        naviBar.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(49)
            make.directionalHorizontalEdges.equalToSuperview()
        }
        
        tableView.snp.makeConstraints { make in
            make.top.equalTo(naviBar.snp.bottom).offset(30)
            make.directionalHorizontalEdges.bottom.equalToSuperview()
        }
        
        imageView.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.bottom.equalToSuperview().inset(70)
        }
    }
    
    private func setTableView() {
        SettingTableViewCell.register(tableView)
    }
}
