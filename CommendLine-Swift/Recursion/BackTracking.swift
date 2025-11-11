//
//  BackTracking.swift
//  CommendLine-Swift
//
//  Created by jingwei on 2025/11/11.
//

import Cocoa

/*
 回溯
 
 八皇后问题

 位运算优化 ：
 1.存储的是 bool 数组
 2.存储的是 比较短的
 */
class BackTracking {

    // 每一行 存放的 皇后的 位置
    var lineList:[Int] = []
    
    // 玩法数量
    var number: Int = 0
    
    func place(_ queen: Int) {
        for _ in 0..<queen {
            lineList.append(-1)
        }
        place(line: 0)
        debugPrint("\(queen) 皇后 一共有 \(number) 种摆法")
    }
    
    private func place(line: Int) {
        
        if line == lineList.count {
            number += 1
            debugPrint("lineList: \(lineList)")
            show()
            return
        }
        
        for col in 0..<lineList.count {
            if isLegal(line: line, col: col) {
                lineList[line] = col
                place(line: line + 1)
            }
        }
        
    }
    
    private func isLegal(line: Int, col: Int) -> Bool {
        // 不能在已经有的列 摆放
        for l in 0..<line {
            let c = lineList[l]
            if col == c { return false }
            // 不能在对角线 摆放
            if line - l == abs(col - c) { return false }
        }
        return true
    }
    
    private func show() {
        for line in 0..<lineList.count {
            
            var str = ""

            for col in 0..<lineList.count {
                if col == lineList[line] {
                    str += " 1"
                } else {
                    str += " 0"
                }
            }
            
            debugPrint(str)
        }
        debugPrint("------------------------")
    }
    
}
