//
//  RadixSort.swift
//  CommendLine-Swift
//
//  Created by jingwei on 2025/10/31.
//

import Cocoa

/*
 基数排序 先取个位数排序 在取10位 百位 排序
 1.进行计数排序 最后得到 有序数组
 2.取10个数字 先对 个位数排序 一样的放到一个数组里面 知道最后
 
 101
 
 / 1 % 10
 / 10 % 10
 
 */
class RadixSort: Sort<Int> {
    var indexArr:[Int] = []

    override func sortFunc() {
        var maxValue = 0

        for index in 0..<self.dataSource.count {
            if self.dataSource[index] > maxValue {
                maxValue = self.dataSource[index]
            }
        }
        
        var num = 1
        while num <= maxValue {
            radixSort(num)
            num *= 10
        }
    }
    
    private func radixSort(_ radix: Int) {
        indexArr = Array(repeating: 0, count: 10)
        for num in self.dataSource {
            indexArr[num / radix % 10] += 1
        }
        // 将计数数组转换为前缀和数组，这样countArray[i]表示小于等于i+minValue的元素个数
        for i in 1..<indexArr.count {
            indexArr[i] += indexArr[i-1]
        }
        countingSort(radix)
    }
    
    // 恢复数组
    private func countingSort(_ radix: Int) {
        var sortedArray = Array(repeating: 0, count: self.dataSource.count)
        
        for num in self.dataSource.reversed() {
            let index = indexArr[num / radix % 10] - 1
            sortedArray[index] = num
            indexArr[num / radix % 10] -= 1
        }
        
        self.dataSource = sortedArray
    }
}
