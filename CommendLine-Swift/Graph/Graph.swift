//
//  Graph.swift
//  CommendLine-Swift
//
//  Created by jingwei on 2025/11/5.
//  https://github.com/szluyu99/Data_Structure_Note

import Cocoa

class Graph<V: Hashable, E: Hashable, W: WeightManager> : GraphProtocol where W.E == E {
    private var map:[V: Vertex<V,E>] = [:]
    private var edges:Set<Edge<V,E>> = []

    // 比较E
    private var weightManager: W

    init(weightManager: W) {
        self.weightManager = weightManager
    }
    
    func verticesSize() -> Int {
        map.count
    }
    
    func edgesSize() -> Int {
        edges.count
    }
    
    // 添加顶点
    func addVertex(v: V) {
        map[v] = Vertex<V, E>(value: v)
    }
    
    // 添加边
    func addEdge(from: V, to: V) {
        _addEdge(from: from, to: to)
    }
    func addEdge(from: V, to: V, weight: E) {
        _addEdge(from: from, to: to, weight: weight)
    }
    
    private func _addEdge(from: V, to: V, weight: E? = nil) {
        if map[from] == nil { addVertex(v: from) }
        if map[to] == nil { addVertex(v: to) }
        let fromVertex = map[from]!
        let toVertex = map[to]!
        let edge = Edge(from: fromVertex, to: toVertex, weight: weight)
        
        if let _ = fromVertex.fromEdges.remove(edge) {
            toVertex.toEdges.remove(edge)
            edges.remove(edge)
        }

        fromVertex.fromEdges.insert(edge)
        toVertex.toEdges.insert(edge)
        edges.insert(edge)
    }
    
    // 删除顶点
    func removeVertex(v: V) {
        guard let vertex = map.removeValue(forKey: v) else { return }
        vertex.fromEdges.forEach { [weak self] edge in
            edge.to.toEdges.remove(edge)
            self?.edges.remove(edge)
        }
        vertex.toEdges.forEach { [weak self] edge in
            edge.from.fromEdges.remove(edge)
            self?.edges.remove(edge)
        }
        vertex.fromEdges.removeAll()
        vertex.toEdges.removeAll()
    }
    
    // 删除边
    func removeEdge(from: V, to: V) {
        guard let fromVertex = self.map[from] else { return }
        guard let toVertex = self.map[to] else { return }
        let edge = Edge(from: fromVertex, to: toVertex)
        fromVertex.fromEdges.remove(edge)
        toVertex.toEdges.remove(edge)
        self.edges.remove(edge)
    }
    
    
    func log() {
        self.map.forEach { (key, value) in
            var logStr = "顶点： \(key) "
            for item in value.fromEdges {
                logStr += "   \(item.from.value) -> \(item.to.value) "
            }
            debugPrint(logStr)
        }
    }
}

// MARK: 遍历
extension Graph {
    
    func bfs(begin: V, visitor:((V) -> Bool)) {
        guard let vertex = self.map[begin] else { return }
        var vertexs:Set<Vertex<V,E>> = []
        var queue:[Vertex<V,E>] = []
        
        queue.append(vertex)
        vertexs.insert(vertex)

        while !queue.isEmpty {
            let vertex = queue.removeFirst()
            if !visitor(vertex.value) { return }
            for edge in vertex.fromEdges {
                if !vertexs.contains(edge.to) {
                    queue.append(edge.to)
                    vertexs.insert(edge.to)
                }
            }
        }
    }
    
    // 一条路走到黑
    func dfs(begin: V) {
        // var vertexs:Set<Vertex<V,E>> = []
        // dfs_recursive(begin: begin, vertexs: &vertexs)
        
        dfs_stack(begin: begin)
    }
    
    private func dfs_recursive(begin: V, vertexs: inout Set<Vertex<V,E>>) {
        guard let vertex = self.map[begin] else { return }
        vertexs.insert(vertex)
        debugPrint("顶点：\(vertex.value)")

        for edge in vertex.fromEdges {
            if !vertexs.contains(edge.to) {
                dfs_recursive(begin: edge.to.value,vertexs: &vertexs)
                vertexs.insert(edge.to)
            }
        }
    }
    
    private func dfs_stack(begin: V) {
        guard let vertex = self.map[begin] else { return }
        
        var vertexs:Set<Vertex<V,E>> = []
        var stack:[Vertex<V,E>] = []
        
        stack.append(vertex)
        vertexs.insert(vertex)
        debugPrint("顶点：\(vertex.value)")


        while !stack.isEmpty {
            let last = stack.removeLast()

            for edge in last.fromEdges {
                if !vertexs.contains(edge.to) {
                    stack.append(edge.from)
                    stack.append(edge.to)
                    vertexs.insert(edge.to)
                    debugPrint("顶点：\(edge.to.value)")
                    break
                }
            }
        }
    }
}



// MARK: 拓扑排序
extension Graph {
    // 拓扑排序 - 拓扑排序是对有向无环图（Directed Acyclic Graph, DAG）中的顶点进行线性排列
    func topologicalSort() -> [V] {
        var toMap:[Vertex<V,E>: Int] = [:]
        var result:[V] = []
        self.map.values.forEach { vertex in
            toMap[vertex] = vertex.toEdges.count
        }
        while !toMap.isEmpty {
            for key in toMap.keys {
                if toMap[key] == 0 {
                    result.append(key.value)
                    toMap.removeValue(forKey: key)
                    // 删除这个 key 的 from
                    for edge in key.fromEdges {
                        if let _ = toMap[edge.to] {
                            toMap[edge.to]! -= 1
                        }
                    }
                }
            }
        }

        return result
    }
}



// MARK: 最小生成树
extension Graph {
    // 一个顶点出发 找到 最小切边
    func prim() -> [EdgeInfo<V, E>] {
        if self.map.count == 0 { return [] }
        
        var edgesSet:[EdgeInfo<V, E>] = []
        var tempSet:Set<Edge<V,E>> = []
        var addVertext:Set<Vertex<V,E>> = []

        let vertext = self.map.values.first!
        for edge in vertext.fromEdges {
            tempSet.insert(edge)
        }
        addVertext.insert(vertext)

        while edgesSet.count != self.map.count - 1 {
            // 找出最小值
            let min = self.findMinEdge(tempSet: tempSet)
            tempSet.remove(min)
            if addVertext.contains(min.to) {
                continue
            }
            edgesSet.append(min.info())
            addVertext.insert(min.to)
            for edge in min.to.fromEdges {
                tempSet.insert(edge)
            }
        }
        return edgesSet
    }
    
    // 可以使用堆优化
    // 需要检测 weight 是否为空
    private func findMinEdge(tempSet:Set<Edge<V,E>>) -> Edge<V,E> {
        var min = tempSet.first!
        for edge in tempSet {
            if self.weightManager.compare(min.weight!, edge.weight!) > 0 {
                min = edge
            }
        }
        return min
    }
    
    
    
    // 排序找到最下的 然后 不构成环的话 继续加到数组里
    func kruskal() -> [EdgeInfo<V, E>] {
        if self.map.count < 2 { return [] }
        if self.map.count == 2 { return [self.map.values.first!.fromEdges.first!.info()] }
        
        var edgesSet:[EdgeInfo<V, E>] = []
        
        let heap = BinaryHeap.create(set: edges) { [weak self] egde1, egde2 in
            guard let self = self else { return 0 }
            return self.weightManager.compare(egde2.weight!, egde1.weight!)
        }
        
        let uf = GenericUnionFind<Vertex<V,E>>(set: Set(map.values))
        
        while edgesSet.count != self.map.count - 1 {
            guard let edge = heap.remove() else { break }
            if uf.isSame(v1: edge.from, v2: edge.to) {
                continue
            }
            edgesSet.append(edge.info())
            uf.union(v1: edge.from, v2: edge.to)
        }
        
        return edgesSet
    }
}



// MARK: 最小生成树
extension Graph {
    // 最短路径 - shortestPath
    // MARK: 返回这个点到所有点的最短路径
    // 类似小石头绑着绳子
    // 先加入开始定点的边 获取最小值
    // 然后对最小的 那个点 进行松弛操作 在比较最小的
    // a b c d e f g h i j k
    func dijkstra(begin: V) -> [V:PathInfo<V,E>] {
        guard let beginVertext = self.map[begin] else { return [:] }
        // 没有权重
        for edge in self.edges {
            if edge.weight == nil { return [:] }
        }
        
        // 最终的结果 就是 获取最小值的 V
        var result: [V:PathInfo<V,E>] = [:]

        // 当前最短路径 - 临时的
        var tempShortest: [Vertex<V,E>:PathInfo<V,E>] = [:]

        for edge in beginVertext.fromEdges {
            let pathInfo = PathInfo<V, E>(totalWeight: edge.weight!)
            pathInfo.path = [edge.info()]
            tempShortest[edge.to] = pathInfo
        }
        
        while !tempShortest.isEmpty {
            // 找最小值
            let (minKey, minValue) = self.minTotalWeight(tempShortest)
            tempShortest.removeValue(forKey: minKey)
            result[minKey.value] = minValue
            
            // 对最小的 那个点 进行松弛操作
            for edge in minKey.fromEdges {
                if result.keys.contains(edge.to.value) || edge.to == beginVertext {
                    continue
                }
                let toVertext = edge.to
                let totalWeight = self.weightManager.add(minValue.totalWeight, edge.weight!)
                if let oldPath = tempShortest[toVertext] {
                    // 更新最小值all
                    let oldWeight = oldPath.totalWeight
                    if self.weightManager.compare(totalWeight, oldWeight) < 0 {
                        oldPath.totalWeight = totalWeight
                        oldPath.path.removeAll()
                        oldPath.path.append(contentsOf: minValue.path)
                        oldPath.path.append(edge.info())
                    }
                } else {
                    let pathInfo = PathInfo<V, E>(totalWeight: totalWeight)
                    pathInfo.path.append(contentsOf: minValue.path)
                    pathInfo.path.append(edge.info())
                    tempShortest[toVertext] = pathInfo
                }
            }
        }
        
        return result
    }
    
    private func minTotalWeight(_ tempShortest: [Vertex<V,E>:PathInfo<V,E>]) -> (Vertex<V,E>, PathInfo<V,E>) {
        var minKey: Vertex<V,E> = tempShortest.keys.first!
        var minValue:PathInfo<V,E> = tempShortest[minKey]!
        tempShortest.forEach { (key, value) in
            if self.weightManager.compare(value.totalWeight, minValue.totalWeight) < 0 {
                minValue = value
                minKey = key
            }
        }
        return (minKey, minValue)
    }
    
    
    // 对所有的边进行 V – 1 次松弛操作 即可得到 最小路径  可以 判断是否有环
    func bellman(begin: V) -> [V:PathInfo<V,E>] {
        guard let beginVertext = self.map[begin] else { return [:] }
        // 没有权重
        for edge in self.edges {
            if edge.weight == nil { return [:] }
        }

        // 当前最短路径 - 临时的
        var tempShortest: [Vertex<V,E>:PathInfo<V,E>] = [:]
        tempShortest[beginVertext] = PathInfo(totalWeight: self.weightManager.zero())
        
        for _ in 0..<self.map.count - 1 {
            for edge in self.edges {
                
                let minValue = tempShortest[edge.from]
                
                guard let minValue = minValue else {
                    continue
                }
                
                let totalWeight = self.weightManager.add(minValue.totalWeight, edge.weight!)
                
                if let oldPath = tempShortest[edge.to] {
                    // 更新最小值all
                    if self.weightManager.compare(totalWeight, oldPath.totalWeight) < 0 {
                        oldPath.totalWeight = totalWeight
                        oldPath.path.removeAll()
                        oldPath.path.append(contentsOf: minValue.path)
                        oldPath.path.append(edge.info())
                    }
                } else {
                    let pathInfo = PathInfo<V, E>(totalWeight: totalWeight)
                    pathInfo.path.append(contentsOf: minValue.path)
                    pathInfo.path.append(edge.info())
                    tempShortest[edge.to] = pathInfo
                }
                
            }
        }
        
        // 最终的结果 就是 获取最小值的 V
        var result: [V:PathInfo<V,E>] = [:]
        for item in tempShortest {
            result[item.key.value] = item.value
        }
        result.removeValue(forKey: begin)
        return result
    }
    
    // 某个点作为k 找到随机的 两个点  检查 dist(i, k) + dist(k, j)＜dist(i, j) 是否成立
    // 成立 设置 设置 dist(i, j) = dist(i, k) + dist(k, j)；
    // 当我们遍历完所有结点 k，dist(i, j) 中记录的便是 i 到 j 的最短路径的距离
    // 返回所有点到所有点的最短路径
    func floyd() -> [V:[V:PathInfo<V,E>]] {
        [:]
    }
}










// MARK: - 顶点对象
private class Vertex<V: Hashable, E: Hashable>: Hashable {
    var value:V
    var toEdges:Set<Edge<V,E>> = [] // 进来的边
    var fromEdges:Set<Edge<V,E>> = [] // 出去的边
    init(value: V) {
        self.value = value
    }
    static func == (lhs: Vertex<V, E>, rhs: Vertex<V, E>) -> Bool {
        lhs.value == rhs.value
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(value)
    }
}

// MARK: - 边对象
private class Edge<V: Hashable, E: Hashable>: Hashable {
    
    var weight:E?
    
    var from:Vertex<V,E>

    var to:Vertex<V,E>
    
    init(from: Vertex<V, E>, to: Vertex<V, E>, weight: E? = nil) {
        self.weight = weight
        self.from = from
        self.to = to
    }

    static func == (lhs: Edge<V,E>, rhs: Edge<V,E>) -> Bool {
        lhs.from == rhs.from && lhs.to == rhs.to
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(from)
        hasher.combine(to)
    }
    
    func info() -> EdgeInfo<V, E> {
        EdgeInfo(from: from.value, to: to.value, weight: weight)
    }
}
