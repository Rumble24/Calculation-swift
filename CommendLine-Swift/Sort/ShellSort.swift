//
//  ShellSort.swift
//  CommendLine-Swift
//
//  Created by jingwei on 2025/10/30.
//

import Cocoa

/*
 划分成不同的列 然后进行排序 执到 1 然后数据就排序好了
 */
class ShellSort<E: Comparable>: Sort<E> {
    private var columns:[Int] = []
    override func sortFunc() {
        var num = self.dataSource.count
        while num > 1 {
            num /= 2
            self.columns.append(num)
        }
        for column in self.columns {
            shellSort(column)
        }
    }
    
    private func shellSort(_ column: Int) {
        for index in stride(from: column, to: self.dataSource.count, by: column) {
            var end = index
            while end > 0, compareIndex(end, end - column) < 0 {
                swapAt(end - column, end)
                end = end - column
            }
        }
    }
}
