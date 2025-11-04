//
//  CountingSort.swift
//  CommendLine-Swift
//
//  Created by jingwei on 2025/10/31.
//

import Cocoa

/*
 对一定范围内的数据进行排序 使用对应的下标记录次数
 可以优化为 稳定算法
 
 */
class CountingSort: Sort<Int>  {
    var indexArr:[Int] = []

    override func sortFunc() {
        var maxValue = 0
        for index in 0..<self.dataSource.count {
            if self.dataSource[index] > maxValue {
                maxValue = self.dataSource[index]
            }
        }
        indexArr = Array(repeating: 0 , count: maxValue + 1)
        for num in self.dataSource {
            indexArr[num] += 1
        }
        countingSort()
    }
    
    // 恢复数组
    private func countingSort() {
        var index = 0
        for i in 0..<indexArr.count {
            for _ in 0..<indexArr[i] {
                self.dataSource[index] = i
                index += 1
            }
        }
    }
}


/*
 优化内存空间
 */
class CountingSort1: Sort<Int>  {
    var indexArr:[Int] = []
    var minValue = 0

    override func sortFunc() {
        var maxValue = 0
        for index in 0..<self.dataSource.count {
            let value = self.dataSource[index]
            if value > maxValue {
                maxValue = self.dataSource[index]
            }
            if value < minValue {
                minValue = self.dataSource[index]
            }
        }
        indexArr = Array(repeating: 0, count: maxValue - minValue + 1)
        for num in self.dataSource {
            indexArr[num - minValue] += 1
        }
        countingSort()
    }
    
    // 恢复数组
    private func countingSort() {
        var index = 0
        for i in 0..<indexArr.count {
            for _ in 0..<indexArr[i] {
                self.dataSource[index] = i + minValue
                index += 1
            }
        }
    }
}


/*
 优化内存空间 优化 维护稳定性 1 3 5 5 7
 0 1 2 3 4 5 6 7
   1   2   4   5
 
 存储的是前面的数据的累加值
 */
class CountingSort2: Sort<Int>  {
    var indexArr:[Int] = []
    var minValue = 0

    override func sortFunc() {
        var maxValue = 0
        for index in 0..<self.dataSource.count {
            let value = self.dataSource[index]
            if value > maxValue {
                maxValue = self.dataSource[index]
            }
            if value < minValue {
                minValue = self.dataSource[index]
            }
        }
        indexArr = Array(repeating: 0, count: maxValue - minValue + 1)
        for num in self.dataSource {
            indexArr[num - minValue] += 1
        }
        // 将计数数组转换为前缀和数组，这样countArray[i]表示小于等于i+minValue的元素个数
        for i in 1..<indexArr.count {
            indexArr[i] += indexArr[i-1]
        }
        countingSort()
    }
    
    // 恢复数组
    private func countingSort() {
        var sortedArray = Array(repeating: 0, count: self.dataSource.count)
        
        for num in self.dataSource.reversed() {
            let index = indexArr[num - minValue] - 1
            sortedArray[index] = num
            indexArr[num - minValue] -= 1
        }
        
        self.dataSource = sortedArray
    }
}
