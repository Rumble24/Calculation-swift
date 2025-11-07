//
//  Graph.swift
//  CommendLine-Swift
//
//  Created by jingwei on 2025/11/5.
//  https://github.com/szluyu99/Data_Structure_Note

import Cocoa

class Graph<V: Hashable, E: Hashable>: GraphProtocol {
    private var map:[V: Vertex<V,E>] = [:]
    private var edges:Set<Edge<V,E>> = []

    // 比较E
    private let compare: (E, E) -> Int
    
    init(compare: @escaping (E, E) -> Int) {
        self.compare = compare
    }
    convenience init() where E: Comparable {
        self.init(compare: {
            if $0 < $1 { return -1 }
            else if $0 > $1 { return 1 }
            else { return 0 }
        })
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
            edgesSet.append(min.toEdgeInfo())
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
            if self.compare(min.weight!, edge.weight!) > 0 {
                min = edge
            }
        }
        return min
    }
    
    
    
    // 排序找到最下的 然后 不构成环的话 继续加到数组里
    func kruskal() -> [EdgeInfo<V, E>] {
        if self.map.count < 2 { return [] }
        if self.map.count == 2 { return [self.map.values.first!.fromEdges.first!.toEdgeInfo()] }
        
        var edgesSet:[EdgeInfo<V, E>] = []
        
        let heap = BinaryHeap.create(set: edges) { [weak self] egde1, egde2 in
            guard let self = self else { return 0 }
            return self.compare(egde2.weight!, egde1.weight!)
        }
        
        let uf = GenericUnionFind<Vertex<V,E>>(set: Set(map.values))
        
        while edgesSet.count != self.map.count - 1 {
            guard let edge = heap.remove() else { break }
            if uf.isSame(v1: edge.from, v2: edge.to) {
                continue
            }
            edgesSet.append(edge.toEdgeInfo())
            uf.union(v1: edge.from, v2: edge.to)
        }
        
        return edgesSet
    }
}



// MARK: 最小生成树
extension Graph {
    // 最短路径 - shortestPath
    func dijkstra() {
        
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
    
    func toEdgeInfo() -> EdgeInfo<V, E> {
        EdgeInfo(from: from.value, to: to.value, weight: weight)
    }
}
