//
//  DPTest.swift
//  CommendLine-Swift
//
//  Created by jingwei on 2025/11/13.
//

import Cocoa

//  MARK: - 找零钱
//  MARK: - 最大连续子序列和
//  MARK: - 最长上升子序列

//  MARK: - 最长公共子序列
//  MARK: - 最长公共子串
//  MARK: - 01背包问题
class DPTest {
    static func test() {
        //        testCoins()
        //        debugPrint("最大连续子序列和: \(DynamicProgramming().maxSubArray([-2, 1, -3, 4, -1, 2, 1, -5, 4]))")
        //        debugPrint("最长上升子序列: \(DynamicProgramming().longestIncreasingSubsequence([10, 2, 2, 5, 1, 7, 101, 18]))")
        
//        debugPrint("最长公共子序列: \(DynamicProgramming().lcs([1, 3, 5, 9, 10], [1, 4, 9, 10]))")
//        debugPrint("最长公共子序列: \(DynamicProgramming().lcs1([1, 3, 5, 9, 10], [1, 4, 9, 10]))")
//        debugPrint("最长公共子序列: \(DynamicProgramming().lcs1([1,2,3,1,2,3,4,1], [1,2,3,1,2,3,4,5,1]))")
        
        
//        debugPrint("最长公共子串: \(DynamicProgramming().lcsub([1, 3, 5, 9, 10], [1, 4, 9, 10]))")
//        debugPrint("最长公共子串: \(DynamicProgramming().longestCommonSubstring("ABDCBA", "ABDCNBA"))")
    }
    
    
    static func testCoins() {
        let coins = 41
        measureTimeWithDate {
            debugPrint("找出 \(coins) 最少需要硬币数： \(DynamicProgramming().coin(coins))")
        }
        measureTimeWithDate {
            debugPrint("找出 \(coins) 最少需要硬币数： \(DynamicProgramming().cacheCoin(coins))")
        }
        measureTimeWithDate {
            debugPrint("找出 \(coins) 最少需要硬币数： \(DynamicProgramming().coin2(coins))")
        }
    }
    
    static func measureTimeWithDate<T>(_ operation: () -> T) {
        let startDate = Date()
        let _ = operation()
        let endDate = Date()
        let duration = endDate.timeIntervalSince(startDate)
        print("函数执行时间: \(duration) 秒")
    }
    
}
