//
//  StringLiteral.swift
//  Kevin
//
//  Created by heerucan on 2023/04/30.
//

import Foundation

enum StringLiteral {
    enum Button {
        static let ok = "확인"
        static let cancel = "취소"
        static let analysis = "분석"
        static let edit = "편집"
        static let listen = "음성 듣기"
        static let share = "공유하기"
        static let result = "응답보기"
        static let card = "분석카드 보기"
    }
    
    enum Calendar {
        static let month = "월"
        static let day = "일"
    }
    
    enum Alert {
        static let title = "뒤로 가실 건가요?"
        static let message = "작성한 글은 저장되지 않아요!"
    }
    
    static let main = "오늘 하루\n내 감정을 기록해봐요 :)"
    static let placeholder = "오늘 하루 어떤 감정을 느꼈는지 기록해볼까요?"
    static let positive = "긍정"
    static let negative = "부정"
    static let neutral = "중립"
}
