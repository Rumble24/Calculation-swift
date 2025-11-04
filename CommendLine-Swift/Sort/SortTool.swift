//
//  SortTool.swift
//  CommendLine-Swift
//
//  Created by jingwei on 2025/10/29.
//

import Cocoa

class SortTool {
    static func generateRandomNumbers(
        count: Int,
        in range: ClosedRange<Int>,
        allowDuplicates: Bool = true
    ) -> [Int] {
        // 校验参数合法性
        guard count > 0 else {
            print("生成数量必须大于0")
            return []
        }
        
        let minValue = range.lowerBound
        let maxValue = range.upperBound
        let rangeCount = maxValue - minValue + 1 // 范围内的数字总数
        
        // 若不允许重复，且需要的数量超过范围总数，则最多只能生成 rangeCount 个
        let actualCount = allowDuplicates ? count : min(count, rangeCount)
        var result: [Int] = []
        var usedNumbers: Set<Int> = [] // 用于记录已生成的数字（去重）
        
        for _ in 0..<actualCount {
            var randomNumber: Int
            repeat {
                // 生成范围内的随机数（arc4random_uniform 是无符号32位随机数，需转换）
                let rangeLength = UInt32(maxValue - minValue + 1)
                randomNumber = minValue + Int(arc4random_uniform(rangeLength))
            } while !allowDuplicates && usedNumbers.contains(randomNumber) // 去重逻辑
            
            result.append(randomNumber)
            if !allowDuplicates {
                usedNumbers.insert(randomNumber)
            }
        }
        
        return result
    }
    
    /// 判断序列是否为升序（非降序）
    /// - Parameter sequence: 待判断的序列（元素需支持比较运算，即遵循 Comparable 协议）
    /// - Returns: 是升序返回 true，否则返回 false
    static func isAscending<T: Comparable>(_ sequence: [T]) -> Bool {
        // 空数组或只有一个元素，默认视为升序
        guard sequence.count > 1 else {
            return true
        }
        
        // 遍历相邻元素，判断是否前一个 <= 后一个
        for i in 0..<sequence.count - 1 {
            let current = sequence[i]
            let next = sequence[i + 1]
            // 若存在前一个 > 后一个，说明不是升序
            if current > next {
                return false
            }
        }
        
        // 所有相邻元素都满足前 <= 后，是升序
        return true
    }
}
