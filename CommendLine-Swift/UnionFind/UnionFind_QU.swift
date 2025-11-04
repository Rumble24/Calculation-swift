//
//  UnionFind_QU.swift
//  CommendLine-Swift
//
//  Created by jingwei on 2025/10/31.
//

import Cocoa

/*
  快速查找 查找合并效率为Olongn
  合并的根结点都放到跟节点上
 */
class UnionFind_QU: UnionFind {
    override func find(v: Int) -> Int {
        var value = self.serials[v]
        if value != v {
            value = self.find(v: value)
        }
        return value
    }
    
    override func union(v1: Int, v2: Int) {
        let index1 = find(v: v1)
        let index2 = find(v: v2)
        if index1 == index2 { return }
        self.serials[index1] = index2
    }
}
