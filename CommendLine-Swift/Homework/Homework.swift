//
//  Homework.swift
//  CommendLine-Swift
//
//  Created by jingwei on 2025/11/11.
//

import Cocoa

class Homework: HomeworkProtocal {

    func removeElements(_ head: ListNode?, _ val: Int) -> ListNode? {
        nil
    }
    
    
    //MARK: -------------------------8皇后问题
    /*
     输入：n = 4
     输出：[[".Q..","...Q","Q...","..Q."],["..Q.","Q...","...Q",".Q.."]]
     解释：如上图所示，4 皇后问题存在两个不同的解法。
     */
    private var queueResult:[[String]] = []
    private var lineArr:[Int] = []
    func solveNQueens(_ n: Int) -> [[String]] {
        for _ in 0..<n {
            lineArr.append(0)
        }
        solveNQueens(line: 0)
        return queueResult
    }
    private func solveNQueens(line: Int) {
        if line == lineArr.count {
            printNQueens()
            return
        }
        for col in 0..<lineArr.count {
            if isVailed(line: line, col: col) {
                lineArr[line] = col
                solveNQueens(line: line + 1)
            }
        }
    }
    private func isVailed(line: Int, col: Int) -> Bool {
        for l in 0..<line {
            let c = lineArr[l]
            if c == col {
                return false
            }
            if line - l == abs(col - c) {
                return false
            }
        }
        return true
    }
    private func printNQueens() {
        var r:[String] = []
        for l in 0..<lineArr.count {
            var str = ""
            for col in 0..<lineArr.count {
                if col == lineArr[l] {
                    str += "Q"
                } else {
                    str += "."
                }
            }
            r.append(str)
        }
        self.queueResult.append(r)
    }

    
    /*
     在大小为 n x n 的网格 grid 上，每个单元格都有一盏灯，最初灯都处于 关闭 状态。

     给你一个由灯的位置组成的二维数组 lamps ，其中 lamps[i] = [rowi, coli] 表示 打开 位于 grid[rowi][coli] 的灯。即便同一盏灯可能在 lamps 中多次列出，不会影响这盏灯处于 打开 状态。

     当一盏灯处于打开状态，它将会照亮 自身所在单元格 以及同一 行 、同一 列 和两条 对角线 上的 所有其他单元格 。

     另给你一个二维数组 queries ，其中 queries[j] = [rowj, colj] 。对于第 j 个查询，如果单元格 [rowj, colj] 是被照亮的，则查询结果为 1 ，否则为 0 。在第 j 次查询之后 [按照查询的顺序] ，关闭 位于单元格 grid[rowj][colj] 上及相邻 8 个方向上（与单元格 grid[rowi][coli] 共享角或边）的任何灯。

     返回一个整数数组 ans 作为答案， ans[j] 应等于第 j 次查询 queries[j] 的结果，1 表示照亮，0 表示未照亮。
     */
    func gridIllumination(_ n: Int, _ lamps: [[Int]], _ queries: [[Int]]) -> [Int] {
        return []
    }
}
