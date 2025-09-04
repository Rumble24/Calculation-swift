//
//  BinarySearchTree.swift
//  CommendLine-Swift
//
//  Created by jingwei on 2025/9/4.
//

import Foundation


class Person:Comparable {
    static func < (lhs: Person, rhs: Person) -> Bool {
        lhs.age < rhs.age
    }
    
    static func == (lhs: Person, rhs: Person) -> Bool {
        lhs.age == rhs.age
    }
    
    var age:Int = 0
    var score:Int = 0
    init(age: Int) {
        self.age = age
    }
}


class Car {
    var price:Int = 0
    init(price: Int) {
        self.price = price
    }
}


class Node<T> {
    var left: Node<T>?
    var right: Node<T>?
    var parent: Node<T>?
    var value: T
    init(value: T, parent: Node<T>? = nil) {
        self.parent = parent
        self.value = value
    }
}

class BinarySearchTree<T> {
    
    static func initBinarySearchTree<E:Comparable>(_ arr: [E]) -> BinarySearchTree<E> {
        let tree = BinarySearchTree<E>()
        for item in arr {
            tree.add(item)
        }
        return tree
    }
    
    private var count: Int = 0
    private var root:Node<T>?
    // 存储比较闭包：(T, T) -> Int 表示 a < b 返回负数，a == b 返回0，a > b 返回正数
    private let compare: (T, T) -> Int
    
    // 1. 通过闭包初始化（适用于所有类型）
    init(compare: @escaping (T, T) -> Int) {
        self.compare = compare
    }
    
    // 2. 便捷初始化：对于遵循Comparable的类型，自动生成比较闭包
    convenience init() where T: Comparable {
        self.init(compare: {
            if $0 < $1 { return -1 }
            else if $0 > $1 { return 1 }
            else { return 0 }
        })
    }
    


    func size() -> Int {
        return self.count
    }
    
    func isEmpty() -> Bool {
        return count == 0
    }
    
    // 二叉搜索树插入操作中，新节点必然是插入到叶子结点的子节点位置，也就是最终成为叶子结点（或者说插入的位置是基于叶子结点的空分支）。
    func add(_ element:T) {
        guard let root = root else {
            root = Node(value: element)
            self.count += 1
            return
        }
        var node: Node<T>?
        var parent: Node<T>?
        var result: Int = 0
        
        node = root
        
        while let tmp = node {
            parent = tmp
            result = self.compare(element, tmp.value)
            if result < 0 {
                node = node?.left
            }
            else if result > 0 {
                node = node?.right
            }
            else {
                node?.value = element
                return
            }
        }

        let newNode = Node(value: element, parent: parent)
        self.count += 1
        if result == -1 {
            parent?.left = newNode
        } else {
            parent?.right = newNode
        }
    }
    
    func remove(_ element:T) {
        guard let node = contains(element) else { return }
        self.count -= 1
        // 分情况 1.根结点 2.分支节点 3.叶子结点
        if node.left == nil && node.right == nil {
            if let value = node.parent?.left?.value, compare(value, element) == 0 {
                node.parent?.left = nil
            } else {
                node.parent?.right = nil
            }
        }
        else if node.left == nil {
            
        } else if node.right == nil {
            
        }
    }
    
    func clear() {
        
    }
    
    func contains(_ element:T) -> Node<T>? {
        var node: Node<T>?
        node = root
        while let tmp = node {
            let result = self.compare(element, tmp.value)
            if result < 0 {
                node = node?.left
            }
            else if result > 0 {
                node = node?.right
            }
            else {
                return node
            }
        }
        return nil
    }
}
