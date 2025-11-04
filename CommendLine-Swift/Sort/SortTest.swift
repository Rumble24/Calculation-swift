//
//  SortTest.swift
//  CommendLine-Swift
//
//  Created by jingwei on 2025/10/29.
//

import Cocoa

class SortTest {
    
    static func bubbleSortTest() {
//        let arr = Array(1...1000)
        let arr = SortTool.generateRandomNumbers(count: 2000, in: 1...10000)
//        arr = SortTool.generateRandomNumbers(count: 10, in: 0...100)
//        let arr = [1,2,3,4,5,6,7,8,9]
//        let arr = [5, 2, 8, 3, 9, 1, 6, 4, 7]
        
        testSort(arr, [
//            BubbleSort(),
//            BubbleSort1(),
//            BubbleSort2(),
//            SelectionSort(),
//            InsertSort(),
//            BinaryInsertSort(),
            HeapSort(),
            MergeSort(),
            MergeSortMJ(),
            QuickSort(),
            ShellSort(),
            CountingSort(),
            CountingSort1(),
            CountingSort2(),
            RadixSort()
        ])
    }

    static func testSort<E:Comparable>(_ arr:[E],_ sorts:[Sort<E>]) {
        testSystemSort(arr)
        for sort in sorts {
            sort.sort(arr)
        }
        var temp = sorts
        temp.sort()
        for sort in temp {
            print(sort)
        }
    }
    
    static func testSystemSort<E:Comparable>(_ arr:[E]) {
        var temp = arr
        let start = NSDate.now.timeIntervalSince1970
        temp.sort()
        let time = NSDate.now.timeIntervalSince1970 - start
        debugPrint("系统排序耗时:\(String(format: "%10.6f", time))s   ")
    }
}




