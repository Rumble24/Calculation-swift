//
//  UnionFind.swift
//  CommendLine-Swift
//
//  Created by jingwei on 2025/10/31.
//

import Cocoa

/*
 是一种数据结构 - 并查集
 并查集主要适用于需要动态维护连通性的场景，特点是
 
 1 2 3 4 5    6 7   8 9 
 */
protocol UnionFindProtocol {
    /**
     * 查找v所属的集合(根结点)
     */
    func find(v: Int) -> Int
    /**
     * 合并v1、v2所在的集合 【下标1 和 下标2】
     */
    func union(v1: Int, v2: Int)
    /**
     * 检查v1、v2是否属于同一集合【下标1 和 下标2】
     */
    func isSame(v1: Int, v2: Int) -> Bool
}


class UnionFind: UnionFindProtocol {
    // 编号数组
    var serials:[Int] = []
    
    init(capacity: Int) {
        for i in 0..<capacity {
            serials.append(i)
        }
    }
    
    func find(v: Int) -> Int {
        fatalError("子类必须重写 find 方法")
    }
    
    func union(v1: Int, v2: Int) {
        fatalError("子类必须重写 union() 方法")
    }
    
    func isSame(v1: Int, v2: Int) -> Bool {
        find(v: v1) == find(v: v2)
    }
}
