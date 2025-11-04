//
//  UnionFindTest.swift
//  CommendLine-Swift
//
//  Created by jingwei on 2025/11/4.
//

import Cocoa

// 0 1 2 3 4 5
// 6 7
// 8 9 10 11
class UnionFindTest {
    static let capacity:Int = 1000000
    
    //MARK: - 实现细节：你的 QU_R_PC 是递归版；在 Swift 中递归在 Debug 下额外开销较大 所以debug下 PC / PS / PH 更加耗时
    static func test() {
        testRandom(ufs: [
//            UnionFind_QF(capacity: capacity),
//            UnionFind_QU(capacity: capacity),
            UnionFind_QU_S(capacity: capacity),
            UnionFind_QU_R(capacity: capacity),
            UnionFind_QU_R_PC(capacity: capacity),
            UnionFind_QU_R_PS(capacity: capacity),
            UnionFind_QU_R_PH(capacity: capacity),
        ])
    }
    
    static func testRandom(ufs:[UnionFind]) {
        for uf in ufs {
            let start = NSDate.now.timeIntervalSince1970
            // 第一部分：随机执行 union 操作 count 次
            for _ in 0..<capacity {
                // 生成 [0, count) 范围内的随机整数作为索引
                let a = Int.random(in: 0..<capacity)
                let b = Int.random(in: 0..<capacity)
                uf.union(v1: a, v2: b) // 调用并查集的 union 方法
            }
            
            // 第二部分：随机执行 isSame 操作 count 次
            for _ in 0..<capacity {
                let a = Int.random(in: 0..<capacity)
                let b = Int.random(in: 0..<capacity)
                let result = uf.isSame(v1: a, v2: b) // 调用并查集的 isSame 方法
                // 可根据需要处理 result（如打印或后续逻辑）
                // print("a: \(a), b: \(b), isSame: \(result)")
            }
            let time = NSDate.now.timeIntervalSince1970 - start
            
            debugPrint("\(String(describing: type(of: uf)))----- ----- ----- 耗时:\(String(format: "%10.6f", time))s")
        }
    }
}


/*
 
 static func test(ufs:[UnionFind]) {
     for uf in ufs {
         let start = NSDate.now.timeIntervalSince1970
         for index in 0..<5 {
             uf.union(v1: index, v2: index + 1)
         }
         for index in 6..<7 {
             uf.union(v1: index, v2: index + 1)
         }
         for index in 8..<11 {
             uf.union(v1: index, v2: index + 1)
         }
         if capacity > 12 {
             for index in 12..<capacity - 1 {
                 uf.union(v1: index, v2: index + 1)
             }
         }
         
         for index in 0..<capacity - 1 {
             let _ = uf.isSame(v1: index, v2: index + 1)
//                debugPrint("v1:\(index)  v2:\(index + 1) 是否在一个集合 \(uf.isSame(v1: index, v2: index + 1))")
         }
         let time = NSDate.now.timeIntervalSince1970 - start
         
         debugPrint("\(String(describing: type(of: uf)))----- ----- ----- 排序耗时:\(String(format: "%10.6f", time))s")
     }
 }
 
 */

/*
 I'll open your Union-Find implementations and the test file to inspect the find/union logic and the benchmark setup; then I'll point out why the variants could be slower and how to fix the benchmark for fair comparison.

 [12 tools called]

 - 先说结论：你这组测试里，基于 rank 的实现已经让树非常矮，额外的“路径压缩/分裂/减半”的写操作开销反而主导了总耗时，所以表现更慢。这是“优化在不需要时反而变负担”的典型例子，尤其在 Debug 构建和随机合并负载下更明显。

 为什么会这样
 - 负载特征：你用的是随机 union + 随机 isSame。基于 rank 的并查集在随机负载下树高本来就很低（接近对数，甚至趋近阿克曼反函数级别）。路径压缩类优化在这种树高已经很低时，省不下来多少步，反而每次 find 要多做数组写入与额外内存访问。
 - 写入成本：PC/PS/PH 都会在 find 期间对数组进行写操作（PC 最多，PS/PH 每步也会写），这些写入导致更多的缓存失效与边界检查开销；在 Swift 的 Debug 模式下，边界检查和泛型/动态派发开销也更明显。
 - 实现细节：你的 QU_R_PC 是递归版；在 Swift 中递归在 Debug 下额外开销较大。PS/PH 是迭代但每步都有双重索引（serials[parent] 或 serials[serials[index]]），对缓存不友好，且每次循环都有写操作。
 - 计时方法：每个实现独立调用 Int.random 生成不同的随机序列，数据分布和“树形演化”可能不同，不完全可比；随机数生成本身也占时，但所有实现都包含这部分，建议把随机数生成移出计时。

 怎么验证与修正
 - 同一输入重放：预先生成两组长度为 capacity 的随机数组 a[]、b[]（union 用）和 a2[]、b2[]（isSame 用），对每个实现复用同一批数组，保证负载一致，公平对比。
 - Release 构建：用 Release 配置（-O 或 -Ofast）运行测试，Swift 的边界检查、泛型和动态派发在 Release 下会被大幅优化，PC/PS/PH 的优势才更容易显现。
 - 预热与多轮均值：先跑一轮预热，再跑多轮取均值/中位数，减小抖动。
 - 增强 find 压力：让 find 次数显著高于 union 次数，或者在 union 阶段少量操作、在 isSame 阶段大量查询，放大路径压缩的收益。
 - 放大规模：把 capacity 与操作次数进一步增大（例如 1e6 级别，视内存而定），让“树变高”的潜在风险出现，从而看见压缩的真正收益。
 - 统一实现习惯：
   - 把 UnionFind 及各子类标记为 final，便于内联和去虚拟化。
   - 避免 import Cocoa，改用 Foundation（或不导入），减少不必要依赖。
   - QU_R_PC 改为迭代实现，减少递归开销（在 Swift 中尤其明显）。
   - 可在性能关键路径上用 @inline(__always) 提示（可选）。

 建议改造的测试代码片段
 - 生成固定输入并复用：
 ```swift
 let capacity = 100_000
 var unionsA = [Int](repeating: 0, count: capacity)
 var unionsB = [Int](repeating: 0, count: capacity)
 var findsA = [Int](repeating: 0, count: capacity)
 var findsB = [Int](repeating: 0, count: capacity)

 for i in 0..<capacity {
     unionsA[i] = Int.random(in: 0..<capacity)
     unionsB[i] = Int.random(in: 0..<capacity)
     findsA[i] = Int.random(in: 0..<capacity)
     findsB[i] = Int.random(in: 0..<capacity)
 }

 // 计时时复用 unionsA/unionsB 和 findsA/findsB
 ```

 - QU_R_PC 迭代版 find（替换递归）：
 ```swift
 override func find(v: Int) -> Int {
     var x = v
     while x != serials[x] {
         serials[x] = serials[serials[x]] // 路径压缩到祖父
         x = serials[x]
     }
     return x
 }
 ```
 注：这是“半压缩式”的常用高效迭代写法，通常比纯递归更快；若要“完全压缩”，可先遍历到根，再回溯一次把路径全部设为根，但那会多一次遍历。

 结论
 - 在你的当前随机负载与 Debug 环境下，“QU_S/QU_R”更快是正常的：树本来就很矮，PC/PS/PH 多出来的写入和额外逻辑反而拖慢速度。
 - 调整测试方法（固定输入、Release、放大 find 压力、放大规模、预热、多轮均值）后，PC/PS/PH 的优势才更可能体现；尤其是当 union 模式更不利于 rank 平衡时，路径压缩能显著降低后续 find 的成本。
 */
