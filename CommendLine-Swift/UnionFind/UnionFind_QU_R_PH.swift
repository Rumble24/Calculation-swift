//
//  UnionFind_QU_R_PH.swift
//  CommendLine-Swift
//
//  Created by jingwei on 2025/11/4.
//

import Cocoa

/*
 路径减半：使路径上每隔一个节点就指向其祖父节点（parent的parent）。
 */
class UnionFind_QU_R_PH: UnionFind_QU_R {
    override func find(v: Int) -> Int {
        var index = v
        while index != serials[index] {
            serials[index] = serials[serials[index]]
            index = serials[index]
        }
        return index
    }
}
