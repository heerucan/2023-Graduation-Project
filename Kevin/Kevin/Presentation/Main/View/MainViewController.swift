//
//  MainViewController.swift
//  Kevin
//
//  Created by heerucan on 2023/05/01.
//

import UIKit

import FSCalendar
import RxSwift
import RxCocoa
import SnapKit
import Then

final class MainViewController: UIViewController {
    
    private let disposeBag = DisposeBag()
    private let viewModel: MainViewModel
    
    var imageDictinoary: [[String: UIImage]] = []
    
    private let naviBar = KevinNavigationBar(type: .main)
    
    private let topTitleLabel = UILabel().then {
        $0.text = StringLiteral.main
        $0.font = .kevinFont(type: .medium22)
        $0.textColor = .black
        $0.numberOfLines = 2
    }
    
    private let calendar = FSCalendar()
    
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
        setCalendarUI()
        bind()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        calendar.reloadData()
    }
    
    private func bind() {
        let input = MainViewModel.Input(
            settingButtonDidTap: naviBar.rightBarButton.rx.tap,
            calendarDidSelected: calendar.rx.didSelect)
        let output = viewModel.transform(input)
    }
}

extension MainViewController: FSCalendarDelegate, FSCalendarDataSource, FSCalendarDelegateAppearance {
    func maximumDate(for calendar: FSCalendar) -> Date {
        return Date()
    }
    
    func calendar(_ calendar: FSCalendar, boundingRectWillChange bounds: CGRect, animated: Bool) {
        calendar.snp.updateConstraints { (make) in
            make.height.equalTo(bounds.height)
        }
        calendar.layoutSubviews()
    }
    
    func calendar(_ calendar: FSCalendar, imageFor date: Date) -> UIImage? {
        for dict in imageDictinoary {
            if let dateString = dict.keys.first, let image = dict[dateString] {
                if dateString == DateFormatterUtil.format(date, .fullSlash) {
                    return image
                }
            }
        }
        return nil
    }
}

extension MainViewController {
    private func setUI() {
        view.backgroundColor = .systemBackground
        navigationController?.navigationBar.isHidden = true
    }
    
    private func setLayout() {
        view.addSubviews([naviBar, topTitleLabel, calendar])
        
        naviBar.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(49)
            make.directionalHorizontalEdges.equalToSuperview()
        }
        
        topTitleLabel.snp.makeConstraints { make in
            make.top.equalTo(naviBar.snp.bottom).offset(2)
            make.leading.equalToSuperview().inset(20)
        }
        
        calendar.snp.makeConstraints { make in
            make.top.equalTo(topTitleLabel.snp.bottom).offset(20)
            make.directionalHorizontalEdges.equalToSuperview()
            make.height.equalTo(330)
        }
    }
    
    private func setCalendarUI() {
        calendar.delegate = self
        calendar.dataSource = self
        calendar.register(CalendarCell.self, forCellReuseIdentifier: CalendarCell.className)
        
        calendar.layoutIfNeeded()
        calendar.locale = Locale(identifier: "ko_KR")
        calendar.headerHeight = 60
        calendar.weekdayHeight = 45
        calendar.placeholderType = .none
        calendar.allowsSelection = true
        calendar.allowsMultipleSelection = false

        calendar.appearance.headerDateFormat = "YYYY년 M월"
        calendar.appearance.headerTitleOffset = CGPoint(x: -80, y: 0)
        calendar.appearance.headerTitleAlignment = .left
        calendar.appearance.headerTitleFont = .kevinFont(type: .medium16)
        calendar.appearance.weekdayFont = .kevinFont(type: .medium12)
        calendar.appearance.titleFont = .kevinFont(type: .regular16)
        calendar.appearance.headerTitleColor = .black
        calendar.appearance.weekdayTextColor = .black
        calendar.appearance.titleDefaultColor = .black
        calendar.appearance.headerMinimumDissolvedAlpha = 0.0
        calendar.appearance.selectionColor = .pink100
        calendar.appearance.titleSelectionColor = .white
    }
}
