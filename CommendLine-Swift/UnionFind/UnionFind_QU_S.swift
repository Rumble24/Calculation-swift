//
//  UnionFind_QU_S.swift
//  CommendLine-Swift
//
//  Created by jingwei on 2025/11/4.
//

import Cocoa

/*
 极限情况下 UnionFind_QU 可能退化为链表
 优化
 1.基于size 的优化 将数量少的放到数量多的上面
 2.基于rank的优化 矮的树 嫁接到 高的树
 
 // 0 1 2 3 4 5
 // 6 7
 // 8 9 10 11
 */
class UnionFind_QU_S: UnionFind_QU {
    private var sizes:[Int] = []
    
    override init(capacity: Int) {
        super.init(capacity: capacity)
        for _ in 0..<capacity {
            self.sizes.append(1)
        }
    }
    
    override func union(v1: Int, v2: Int) {
        let index1 = find(v: v1)
        let index2 = find(v: v2)
        
        if index1 == index2 { return }

        let size1 = self.sizes[index1]
        let size2 = self.sizes[index2]

        if size1 < size2 {
            self.serials[index1] = index2
            self.sizes[index2] += size1
        } else {
            self.serials[index2] = index1
            self.sizes[index1] += size2
        }
    }
}
