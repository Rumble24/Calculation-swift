//
//  GenericUnionFind.swift
//  CommendLine-Swift
//
//  Created by jingwei on 2025/11/6.
//

import Cocoa

class GenericUnionFind<E: Hashable> {
    // 编号数组
    private var serials:[E:Node] = [:]

    init() {
        
    }
    
    init(keys: [E]) {
        self.makeSets(keys: keys)
    }
    
    init(set: Set<E>) {
        set.forEach { e in
            self.makeSet(key: e)
        }
    }
    
    
    func makeSet(key: E) {
        if let _ = serials[key] { return }
        serials[key] = Node(value: key)
    }
    
    func makeSets(keys: [E]) {
        for key in keys {
            makeSet(key: key)
        }
    }
    
    // 查找v所属的集合(根结点)
    func find(v: E) -> E? {
        findNode(v: v)?.value
    }
    
    func union(v1: E, v2: E) {
        guard let index1 = findNode(v: v1) else { return }
        guard let index2 = findNode(v: v2) else { return }
        
        if index1 === index2 { return }

        let rank1 = index1.rank
        let rank2 = index2.rank

        if rank1 < rank2 {
            index1.parent = index2
        } else if rank1 > rank2 {
            index2.parent = index1
        } else {
            index2.parent = index1
            index1.rank += 1
        }
    }
    
    func isSame(v1: E, v2: E) -> Bool {
        guard let node1 = findNode(v: v1) else { return false }
        guard let node2 = findNode(v: v2) else { return false }
        return node1 === node2
    }
    
    // 查找v所属的集合(根结点)
    private func findNode(v: E) -> Node? {
        guard let _ = serials[v] else { return nil }
        var node = serials[v]!
        while node.value != node.parent.value {
            node.parent = node.parent.parent
            node = node.parent
        }
        return node
    }
    
    private class Node {
        var value: E
        var rank: Int = 1
        lazy var parent: Node = self
        init(value: E) {
            self.value = value
        }
    }
}
