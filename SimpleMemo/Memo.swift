//
//  Memo.swift
//  SimpleMemo
//
//  Created by 이문정 on 2021/05/19.
//

import UIKit

struct Memo: Codable, Equatable {
    let id: Int
    var content: String
    var date: Date
    
    mutating func update(content: String, date: Date) {
        self.content = content
        self.date = date
    }
    static func == (lhs: Self, rhs: Self) -> Bool {
        return lhs.id == rhs.id
    }
}

class MemoManager {
    
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
        Storage.store(memos, to: .documents, as: "todos.json")
    }
    
    func retrieveMemo() {
        memos = Storage.retrive("todos.json", from: .documents, as: [Memo].self) ?? []
        
        let lastId = memos.last?.id ?? 0
        MemoManager.lastId = lastId
    }
}

class MemoViewModel {
    
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
}

