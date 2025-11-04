//
//  Heap.swift
//  CommendLine-Swift
//
//  Created by jingwei on 2025/10/28.
//

import Cocoa

protocol Heap {
    associatedtype E

    func size() -> Int

    func isEmpty() -> Bool

    func clear()

    func add(var1: E)

    // 获取堆顶的元素
    func get() -> E?

    // 删除堆顶的元素
    func remove() -> E?

    // 删除堆顶的元素 同时插入一个新的元素
    func replace(var1: E) -> E
}


class AbstractHeap<E> : Heap {
    var elements:[E] = []

    // 存储比较闭包：(T, T) -> Int 表示 a < b 返回负数，a == b 返回0，a > b 返回正数
    let compare: (E, E) -> Int
    
    // 1. 通过闭包初始化（适用于所有类型）
    init(compare: @escaping (E, E) -> Int) {
        self.compare = compare
    }
    
    // 2. 便捷初始化：对于遵循Comparable的类型，自动生成比较闭包
    convenience init() where E: Comparable {
        self.init(compare: {
            if $0 < $1 { return -1 }
            else if $0 > $1 { return 1 }
            else { return 0 }
        })
    }
    
    func size() -> Int {
        elements.count
    }
    
    func isEmpty() -> Bool {
        elements.isEmpty
    }
    
    func clear() {
        elements.removeAll()
    }
    
    func add(var1: E) {
        
    }
    
    func get() -> E? {
        elements.first
    }
    
    func remove() -> E? {
        fatalError("Subclasses must implement this method")

    }
    
    func replace(var1: E) -> E {
        fatalError("Subclasses must implement this method")
    }
}
