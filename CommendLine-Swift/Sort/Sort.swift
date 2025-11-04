//
//  Sort.swift
//  CommendLine-Swift
//
//  Created by jingwei on 2025/10/29.
//

import Cocoa

/*
 冒泡排序 两两交换
 
 选择排序 选择一个 放到后面
 堆排序
 
 插入排序
 希尔排序 - 相当于插入排序的优化版本

 快排
 归并排序 - merge
 
 桶排序
 计数排序
 基数排序
 
 系统采用的是 TimSort - 结合了归并排序和插入排序的优点
 */
class Sort<E:Comparable>: CustomStringConvertible, Equatable, Comparable {
    var swapCount:Int = 0
    var compareCount:Int = 0
    var time:Double = 0
    var dataSource:[E] = []

    func sort(_ arr:[E]) {
        guard arr.count > 1 else { return }
        let start = NSDate.now.timeIntervalSince1970
        self.dataSource = arr
        sortFunc()
        self.time = NSDate.now.timeIntervalSince1970 - start
    }
    
    func sortFunc() {
        
    }
    
    func compare(_ i: E, _ j: E) -> Int {
        compareCount = compareCount + 1
        if i == j { return 0 }
        if i > j { return 1 }
        return -1
    }
    
    func compareIndex(_ i: Int, _ j: Int) -> Int {
        compareCount = compareCount + 1
        return compare(self.dataSource[i], self.dataSource[j])
    }
    
    /*
     其实是等价的
     但是 debug 模式下 我们自己写的代码没有进行编译器优化 swapAt 进行了 编译器优化
     release下的话就是 完全一样的了
     */
    func swapAt(_ i: Int, _ j: Int) {
        swapCount = swapCount + 1

        let tmp = dataSource[i]
        dataSource[i] = dataSource[j]
        dataSource[j] = tmp
        
        //self.dataSource.swapAt(i, j)
    }
    
    var description: String {
        let className = String(describing: type(of: self)).replacingOccurrences(of: "<Int>", with: "")
        let isAscending = SortTool.isAscending(self.dataSource)
        
        return "\(className.padding(toLength: 15, withPad: " ", startingAt: 0)) " +
        "排序耗时:\(String(format: "%10.6f", time))s   " +
        "交换次数:\(String(format: "%10d", swapCount))   " +
        "比较次数:\(String(format: "%10d", compareCount))   " +
        "是否是升序: \(isAscending)"
    }
    
    
    // Equatable 协议要求
    static func == (lhs: Sort, rhs: Sort) -> Bool {
        return lhs.time == rhs.time
    }
    
    // Comparable 协议要求
    static func < (lhs: Sort, rhs: Sort) -> Bool {
        // 按年龄排序
        return lhs.time < rhs.time
    }
}
