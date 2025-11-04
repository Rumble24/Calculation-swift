//
//  UnionFind_QU_R_PS.swift
//  CommendLine-Swift
//
//  Created by jingwei on 2025/11/4.
//

import Cocoa

/*
 路径分裂：使路径上的每个节点都指向其祖父节点（parent的parent）。
 */
class UnionFind_QU_R_PS: UnionFind_QU_R {
    override func find(v: Int) -> Int {
        var index = v
        while index != serials[index] {
            let parent = serials[index]
            serials[index] = serials[parent]
            index = parent
        }
        return index
    }
}
