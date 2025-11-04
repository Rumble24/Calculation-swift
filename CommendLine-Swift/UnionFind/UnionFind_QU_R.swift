//
//  UnionFind_QU_R.swift
//  CommendLine-Swift
//
//  Created by jingwei on 2025/11/4.
//

import Cocoa

/*
 极限情况下 UnionFind_QU 可能退化为链表
 优化
 1.基于size 的优化 将数量少的放到数量多的上面
 2.基于rank的优化 矮的树 嫁接到 高的树  只有等于才会让树增高
 */
class UnionFind_QU_R: UnionFind_QU {
    private var rank:[Int] = []
    
    override init(capacity: Int) {
        super.init(capacity: capacity)
        for _ in 0..<capacity {
            self.rank.append(1)
        }
    }
    
    override func union(v1: Int, v2: Int) {
        let index1 = find(v: v1)
        let index2 = find(v: v2)
        
        if index1 == index2 { return }

        let rank1 = self.rank[index1]
        let rank2 = self.rank[index2]

        if rank1 < rank2 {
            self.serials[index1] = index2
        } else if rank1 > rank2 {
            self.serials[index2] = index1
        } else {
            self.serials[index2] = index1
            self.rank[index1] += 1
        }
    }
}
