//
//  Memo.swift
//  SimpleMemo
//
//  Created by 이문정 on 2021/05/19.
//

import UIKit

//MARK: Model

// 객체들 간 동등비교를 하기 위해서 Equatable를 채택해야 한다.
struct Memo: Codable, Equatable {
    let id: Int
    var content: String
    var date: Date
    
    // 자신의 프로퍼티 값을 수정할 때 클래스의 인스턴스 메서드는 크게 신경안써도 되지만, 구조체나 열거형 등은 값 타입이므로 , mutaitng 키워드를 붙여서 해당 메서드가 인스턴스 내부의 값을 변경 한다는 것을 암시해야 한다.
    mutating func update(content: String, date: Date) {
        self.content = content
        self.date = date
    }
    // 동등 조건 설정: 아이디로 동등함을 판단
    static func == (lhs: Self, rhs: Self) -> Bool {
        return lhs.id == rhs.id
    }
}

class MemoManager {
    
    // 싱글톤 객체 생성: 앱 내에서 한개의 객체만 생성
    static let shared = MemoManager()
    
    static var lastId: Int = 0
    
    var memos: [Memo] = []
    
    func createMemo(content: String, date: Date) -> Memo {
        let nextId = MemoManager.lastId + 1
        MemoManager.lastId = nextId
        return Memo(id: nextId, content: content, date: Date())
    }
    
    func addMemo(_ memo: Memo) {
        memos.append(memo)
        saveMemo()
    }
    
    func deletMemo(_ memo: Memo) {
        if let index = memos.firstIndex(of: memo) {
            memos.remove(at: index)
        }
        saveMemo()
    }
    
    func updateMemo(_ memo: Memo) {
        guard let index = memos.firstIndex(of: memo) else { return }
        memos[index].update(content: memo.content, date: memo.date)
        saveMemo()
    }
    
    func saveMemo() {
        Storage.store(memos, to: .documents, as: "memos.json")
    }
    
    func retrieveMemo() {
        memos = Storage.retrive("memos.json", from: .documents, as: [Memo].self) ?? []
        
        let lastId = memos.last?.id ?? 0
        MemoManager.lastId = lastId
    }
    
    func swapMemo(_ sourceIndex : Int, _ targetIndex: Int) {
        let temp = memos[sourceIndex]
        let targetMemo = memos[targetIndex]
        memos[sourceIndex].update(content: targetMemo.content, date: targetMemo.date)
        memos[targetIndex].update(content: temp.content, date: temp.date)
        saveMemo()
    }
}

//MARK: ViewModel

class MemoViewModel {
    
    //비공개 접근수준은 가장 한정적인 범위이다.
    //비공개 접근수준으로 지정된 요소는 그 기능을 정의하고 구현한 범위 내에서만 사용할 수 있다.
    //비공개 접근수준으로 지정한 기능은 같은 소스파일 안에 구현한 다른 타입이나 기능에서도 사용할 수 없다.
    private let manager = MemoManager.shared
    
    var memos: [Memo] {
        return manager.memos
    }
    
    func addMemo(_ memo: Memo) {
        manager.addMemo(memo)
    }
    
    func deleteMemo(_ memo: Memo) {
        manager.deletMemo(memo)
    }
    
    func updateMemo(_ memo: Memo) {
        manager.updateMemo(memo)
    }
    
    func loadTasks() {
        manager.retrieveMemo()
    }
    
    func swapMemo(_ sourceIndex: Int, _ targetIndex: Int) {
        manager.swapMemo(sourceIndex, targetIndex)
    }
}

