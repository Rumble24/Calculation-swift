//
//  Graph.swift
//  CommendLine-Swift
//
//  Created by jingwei on 2025/11/5.
//

import Cocoa

protocol GraphProtocol {
    
    // 添加定点的名字
    associatedtype V
    // 权重
    associatedtype E

    // 边的数量
    func edgesSize() -> Int
    
    // 顶点数量
    func verticesSize() -> Int
    
    // 添加顶点
    func addVertex(v: V)
    
    // 添加边
    func addEdge(from: V, to: V)
    // 添加边
    func addEdge(from: V, to: V, weight: E)
    
    // 删除顶点
    func removeVertex(v: V)
    // 删除边
    func removeEdge(from: V, to: V)
    
    // 广度优先 - 类似层序遍历 - 队列
    func bfs(begin: V, visitor:((V) -> Bool))
    // 深度优先 - 类似递归 - 栈 - 探到地 / 非递归
    func dfs(begin: V)
    
    // 拓扑排序 - 拓扑排序是对有向无环图（Directed Acyclic Graph, DAG）中的顶点进行线性排列
    func topologicalSort() -> [V]
    
    // 最小生成树 - 无向图的极小连通子图【是指图中任意两个顶点之间都存在至少一条路径 - 直接或间接相连】
    // 一个定点出发 找到 最小切边
    func prim() -> [EdgeInfo<V, E>]
    // 排序找到最下的 然后 不构成环的话 继续加到数组里
    func kruskal() -> [EdgeInfo<V, E>]

    // 最短路径 - shortestPath
    // 类似小石头绑着绳子
    func dijkstra(begin: V)
    
    // 对所有的边进行 V – 1 次松弛操作 即可得到 最小路径  可以 判断是否有环
    func bellman(begin: V)
    
    // 某个点作为k 找到随机的 两个点  检查 dist(i, k) + dist(k, j)＜dist(i, j) 是否成立
    // 成立 设置 设置 dist(i, j) = dist(i, k) + dist(k, j)；
    // 当我们遍历完所有结点 k，dist(i, j) 中记录的便是 i 到 j 的最短路径的距离
    func floyd()
}


class EdgeInfo<V,E> {
    var from:V

    var to:V
    
    var weight:E?

    init(from: V, to: V, weight: E? = nil) {
        self.weight = weight
        self.from = from
        self.to = to
    }
}
