//
//  UnionFind_QU_R_PC.swift
//  CommendLine-Swift
//
//  Created by jingwei on 2025/11/4.
//

import Cocoa

/*
 虽然有了基于 rank 的优化，树会相对平衡一点，但是随着 union 次数的增多：树的高度依然会越来越高，导致 find 操作变慢，尤其是底层节点 (因为 find 是不断向上找到根节点) 。
 
 什么是路径压缩？

 在 find 时使路径上的所有节点都指向根节点，从而降低树的高度。
 */
class UnionFind_QU_R_PC: UnionFind_QU_R {
//    override func find(v: Int) -> Int {
//        let value = serials[v]
//        if value != v {
//            serials[v] = self.find(v: serials[v])
//        }
//        // 所有的指向根节点
//        return serials[v]
//    }
//    
    override func find(v: Int) -> Int {
        if serials[v] != v {
            serials[v] = find(v: serials[v])  // 递归压缩路径
        }
        return serials[v]
    }
//    override func find(v: Int) -> Int {
//        var x = v
//        while x != serials[x] {
//            serials[x] = serials[serials[x]] // 路径压缩到祖父
//            x = serials[x]
//        }
//        return x
//    }
}
