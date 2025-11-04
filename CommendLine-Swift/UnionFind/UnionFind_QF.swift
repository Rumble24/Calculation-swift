//
//  UnionFind_QF.swift
//  CommendLine-Swift
//
//  Created by jingwei on 2025/10/31.
//

import Cocoa

/*
  快速查找 查找效率为O1
  合并的所有的子节点都放到跟节点上
 */
class UnionFind_QF: UnionFind {
    override func find(v: Int) -> Int {
        self.serials[v]
    }
    
    override func union(v1: Int, v2: Int) {
        let v1Value = find(v: v1)
        let v2Value = find(v: v2)
        if v1Value == v2Value { return }
        for index in 0..<self.serials.count {
            if self.serials[index] == v1Value {
                self.serials[index] = v2Value
            }
        }
    }
}
