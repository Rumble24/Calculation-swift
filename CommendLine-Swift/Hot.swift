//
//  File.swift
//  CommendLine-Swift
//
//  Created by jingwei on 2025/6/10.
//

import Foundation


protocol HotProtocal {
    // 1. 两数之和
    func twoSum(_ nums: [Int], _ target: Int) -> [Int]
    // 49. 字母异位词分组
    func groupAnagrams(_ strs: [String]) -> [[String]]
    // 128. 最长连续序列
    func longestConsecutive(_ nums: [Int]) -> Int
    // 283. 移动零
    func moveZeroes(_ nums: inout [Int])
    // 11. 盛最多水的容器
    func maxArea(_ height: [Int]) -> Int
    // 24. 反转链表 给定单链表的头节点 head
    func reverseList(_ head: ListNode?) -> ListNode?
    // 15.三数之和
    func threeSum(_ nums: [Int]) -> [[Int]]
    // 42. 接雨水 动态规划
    func trap(_ height: [Int]) -> Int
    // 438. 找到字符串中所有字母异位词
    func findAnagrams(_ s: String, _ p: String) -> [Int]
}

class HotTest {
    static func test() {
//        debugPrint("最长连续序列 \(Solution().longestConsecutive([100,4,200,1,3,2,5,7]))")
//        debugPrint("盛最多水的容器 \(Solution().maxArea([0,1,0,2,1,0,1,3,2,1,2,1]))")
//        debugPrint("三数之和 \(Solution().threeSum([-1,0,1,2,-1,-4]))")
//        debugPrint("三数之和 1 \(Solution().threeSum1([-4,-2,-2,-2,0,1,2,2,2,3,3,4,4,6,6]))")
        
        
//        debugPrint("接雨水 \(Solution().trap([0,1,0,2,1,0,1,3,2,1,2,1]))")
//        debugPrint("接雨水 \(Solution().trap([4,2,0,3,2,5]))")
        debugPrint("接雨水 \(Solution().trap([5,4,1,2]))")
    }
}



// MARK: 1. 两数之和
class Solution: HotProtocal {
    /*
     输入：nums = [2,7,11,15], target = 9
     输出：[0,1]
     解释：因为 nums[0] + nums[1] == 9 ，返回 [0, 1] 。
     */
    func twoSum(_ nums: [Int], _ target: Int) -> [Int] {
        func startIndex(_ index: Int) -> [Int]? {
            for i in index + 1..<nums.count {
                if nums[i] + nums[index] == target {
                    return [index, i]
                }
            }
            return nil
        }
        for i in 0..<nums.count - 1 {
            if let result = startIndex(i) {
                return result
            }
        }
        return []
    }
    func twoSum1(_ nums: [Int], _ target: Int) -> [Int] {
        var dic:[Int: Int] = [:]
        for i in 0..<nums.count {
            if dic.keys.contains(target - nums[i]) {
                return [i,dic[target - nums[i]]!]
            }
            dic[nums[i]] = i
        }
        return []
    }
    
    // MARK: 49. 字母异位词分组
    /*
     输入: strs = ["eat", "tea", "tan", "ate", "nat", "bat"]
     输出: [["bat"],["nat","tan"],["ate","eat","tea"]]
     */
    //1.排序后一样 2.包含的个数一样
    func groupAnagrams(_ strs: [String]) -> [[String]] {
        if strs.count <= 1 {
            return [strs]
        }
        
        var charNums:[String: [String: Int]] = [:]
        var compares: [String] = []
        var results: [[String]] = []
        
        
        for str in strs {
            var nums:[String: Int] = [:]
            for char in str {
                let charStr = "\(char)"
                if let num = nums[charStr] {
                    nums[charStr] = num + 1
                } else {
                    nums[charStr] = 1
                }
            }
            charNums[str] = nums
        }
        
        func bijiao(_ a: String, _ b: String) -> Bool {
            if a.count == b.count {
                let numsa = charNums[a]
                let numsb = charNums[b]
                for key in numsa!.keys {
                    if let numa = numsa![key], let numb = numsb![key], numa == numb {
                        continue
                    } else {
                        return false
                    }
                }
                return true
            }
            return false
        }
        
        func start(_ index: Int) {
            var result: [String] = [strs[index]]
            for i in index + 1..<strs.count {
                if bijiao(strs[index], strs[i]) {
                    result.append(strs[i])
                    compares.append(strs[i])
                }
            }
            results.append(result)
        }
        
        for i in 0..<strs.count {
            if compares.contains(strs[i]) == false {
                start(i)
            }
        }
        
        return results
    }
    //1.排序后一样 2.包含的个数一样
    static func groupAnagrams1(_ strs: [String]) -> [[String]] {
        if strs.count <= 1 {
            return [strs]
        }
        
        var charNums:[String: String] = [:]
        var compares: [String] = []
        var results: [[String]] = []
        
        
        for str in strs {
            charNums[str] = "\(str.sorted())"
        }
        
        func bijiao(_ a: String, _ b: String) -> Bool {
            if a.count == b.count {
                let numsa = charNums[a]
                let numsb = charNums[b]
                return numsa == numsb
            }
            return false
        }
        
        func start(_ index: Int) {
            var result: [String] = [strs[index]]
            for i in index + 1..<strs.count {
                if bijiao(strs[index], strs[i]) {
                    result.append(strs[i])
                    compares.append(strs[i])
                }
            }
            results.append(result)
        }
        
        for i in 0..<strs.count {
            if compares.contains(strs[i]) == false {
                start(i)
            }
        }
        
        return results
    }
    
    
    // MARK: 128. 最长连续序列
    /*
     输入：nums = [100,4,200,1,3,2]
     输出：4
     解释：最长数字连续序列是 [1, 2, 3, 4]。它的长度为 4。
     思路： 看看它是不是 开始的
     */
    func longestConsecutive(_ nums: [Int]) -> Int {
        guard nums.count > 0 else {
            return 0
        }
        let set = Set(nums)
        var result = 0
        for num in set {
            if !set.contains(num - 1) {
                var start = num
                while set.contains(start + 1) {
                    start += 1
                }
                result = max(result, start - num + 1)
            }
        }
        return result
    }
    
    
    // MARK: 283. 移动零
    //var nums = [0,1,0,3,12]
    //Solution.moveZeroes(&nums)
    //print(nums)
    /*
     给定一个数组 nums，编写一个函数将所有 0 移动到数组的末尾，同时保持非零元素的相对顺序。
     
     请注意 ，必须在不复制数组的情况下原地对数组进行操作。
     
     示例 1:
     
     输入: nums = [0,1,0,3,12]
     输出: [1,3,12,0,0]
     示例 2:
     
     输入: nums = [0]
     输出: [0]
     */
    func moveZeroes(_ nums: inout [Int]) {
        var left = 0
        var right = 0
        let count = nums.count
        while right < count {
            if nums[right] != 0 {
                nums.swapAt(left, right)
                left += 1
            }
            right += 1
        }
    }
    
    
    // MARK: 11. 盛最多水的容器
    /// 木桶原理，木桶能装多少的水，取决于短的木板，
    /// 按照本题算面积，应该是拿短的当高，高确定的情况下，长度最长面积就最大，也就是不管怎么移动长的那根（前提是往短的这边移动），
    /// 面积都会小于最开始的面积，所以需要移动短的那根，再以此往复的寻找最大的面积。
    
    /*
     输入：[1,8,6,2,5,4,8,3,7]
     输出：49
     解释：图中垂直线代表输入数组 [1,8,6,2,5,4,8,3,7]。在此情况下，容器能够容纳水（表示为蓝色部分）的最大值为 49。
     */
    
    func maxArea(_ height: [Int]) -> Int {
        if height.count < 2 {
            return 0
        }
        
        var left = 0
        var right = height.count - 1
        var area = 0
        
        while left < right  {
            area = max(area, min(height[left], height[right]) * (right - left))
            if height[left] < height[right] {
                left += 1
            } else {
                right -= 1
            }
        }
        
        return area
    }
    
    
    // 24. 反转链表 给定单链表的头节点 head - 1 2 3 4
    func reverseList(_ head: ListNode?) -> ListNode? {
        var pre:ListNode? = nil
        var current = head
        while current != nil {
            let next = current?.next
            current?.next = pre
            pre = current
            current = next
        }
        return current
    }
    
    /*
     
     输入：nums = [-1,0,1,2,-1,-4]
     输出：[[-1,-1,2],[-1,0,1]]
     解释：
     nums[0] + nums[1] + nums[2] = (-1) + 0 + 1 = 0 。
     nums[1] + nums[2] + nums[4] = 0 + 1 + (-1) = 0 。
     nums[0] + nums[3] + nums[4] = (-1) + 2 + (-1) = 0 。
     不同的三元组是 [-1,0,1] 和 [-1,-1,2] 。
     注意，输出的顺序和三元组的顺序并不重要。
     
     给你一个整数数组 nums ，判断是否存在三元组 [nums[i], nums[j], nums[k]] 满足 i != j、i != k 且 j != k ，同时还满足 nums[i] + nums[j] + nums[k] == 0 。请你返回所有和为 0 且不重复的三元组。

     注意：答案中不可以包含重复的三元组。
     */
    func threeSum(_ nums: [Int]) -> [[Int]] {
        guard nums.count > 2 else {
            return []
        }
        let sort = nums.sorted()
        debugPrint("sort \(sort)")
        var last0: Int = Int.min
        var last1: Int = Int.min

        var result:[[Int]] = []
        for i in 0..<sort.count - 2 {
            for j in i + 1..<sort.count - 1 {
                for k in j + 1..<sort.count {
                    if sort[i] + sort[j] + sort[k] == 0, last0 != sort[i], last1 != sort[j] {
                        result.append([sort[i] , sort[j], sort[k]])
                    }
                }
                last1 = sort[j]
            }
            last0 = sort[i]
        }
        
        return result
    }
    
    // 双指针 那么只需要 on2
    // [-4,-2,-2,-2,0,1,2,2,2,3,3,4,4,6,6]
    func threeSum1(_ nums: [Int]) -> [[Int]] {
        guard nums.count >= 3 else { return [] }
        
        let sorted = nums.sorted()
        var result = [[Int]]()
        
        for i in 0..<sorted.count - 2 {
            // 优化1: 跳过重复的 i
            if i > 0 && sorted[i] == sorted[i - 1] {
                continue
            }
            
            // 优化2: 提前终止 - 如果当前数已经大于0，后面的数都更大，不可能和为0
            if sorted[i] > 0 {
                break
            }
            
            var left = i + 1
            var right = sorted.count - 1
            
            while left < right {
                let sum = sorted[i] + sorted[left] + sorted[right]
                
                if sum == 0 {
                    result.append([sorted[i], sorted[left], sorted[right]])
                    
                    // 优化3: 跳过重复的 left 和 right
                    while left < right && sorted[left] == sorted[left + 1] {
                        left += 1
                    }
                    while left < right && sorted[right] == sorted[right - 1] {
                        right -= 1
                    }
                    
                    left += 1
                    right -= 1
                } else if sum < 0 {
                    left += 1
                } else {
                    right -= 1
                }
            }
        }
        
        return result
    }
    
    
    // 42. 接雨水 [0,1,0,2,1,0,1,3,2,1,2, 1]
    //            0 1 2 3 4 5 6 7 8 9 10 11
    // 动态规划问题
    func trap(_ height: [Int]) -> Int {
        guard height.count > 2 else {
            return 0
        }
        return 0
    }
    
    // 438. 找到字符串中所有字母异位词
    /*
     示例 1:

     输入: s = "cbaebabacd", p = "abc"
     输出: [0,6]
     解释:
     起始索引等于 0 的子串是 "cba", 它是 "abc" 的异位词。
     起始索引等于 6 的子串是 "bac", 它是 "abc" 的异位词。
     */
    /*
     思路：周到所有的异位词 然后一一对比
     */
    
    func findAnagrams(_ s: String, _ p: String) -> [Int] {
     
        func getAllAnagrams() -> [String] {
            var arr:[[Character]] = []
            for (index, char) in p.enumerated() {
                if index == 0 {
                    arr.append([char])
                } else {
                    var temp:[Character] = []
                    for item in arr {
                        temp
                    }
                }
            }
            return []
        }
    }
    
}
