//
//  GraphTest.swift
//  CommendLine-Swift
//
//  Created by jingwei on 2025/11/5.
//

import Cocoa

class GraphTest {
    
    static func test() {
//        graphtest()
//        primTest()
//        dijkstraTest()
        bellmanTest()
    }
    

    static func graphtest() {
        let graph = directedGraph(GraphData.TOPO)
        debugPrint("图 基本测试 ----- -----")
        graph.removeEdge(from: 0, to: 2)
        graph.log()
        
        debugPrint("图 广度优先 遍历 ----- -----")
        graph.bfs(begin: 3) { value in
            debugPrint("顶点：\(value)")
            return true
        }
        debugPrint("图 深度优先 遍历 ----- -----")
        graph.dfs(begin: 3)
        
        debugPrint("图 拓扑排序 工程依赖问题----- -----")
        let r = graph.topologicalSort()
        for item in r {
            debugPrint(item)
        }
    }
    
    static func primTest() {
        debugPrint("最小生成树 prim 算法----- -----")
        let graph = undirectedGraph(GraphData.MST_02)
        let prims = graph.prim()
        for item in prims {
            debugPrint(item.weight ?? 0)
        }

        debugPrint("最小生成树 kruskal 算法----- -----")
        let kruskal = graph.kruskal()
        for item in kruskal {
            debugPrint(item.weight ?? 0)
        }
    }
    
    static func dijkstraTest() {
        debugPrint("最短路径 dijkstra 算法----- -----")
        let graph = undirectedGraph(GraphData.SP)
        let dijkstra = graph.dijkstra(begin: "A")
        for item in dijkstra {
            print("A到\(item.key) \(item.value)")
        }
    }
    
    static func bellmanTest() {
        debugPrint("最短路径 bellman 算法----- -----")
        let graph = directedGraph(GraphData.BF_SP)
        let bellman = graph.bellman(begin: "A")
        for item in bellman {
            print("A到\(item.key) \(item.value)")
        }
    }

    // 有向图
    static func directedGraph(_ data: [[Any]]) -> Graph<AnyHashable, Double, DefaultWeightManager<Double>> {
        let graph = Graph<AnyHashable, Double, DefaultWeightManager>(weightManager: DefaultWeightManager<Double>())
        for item in data {
            if item.count == 1 {
                if let vertex = item[0] as? AnyHashable {
                    graph.addVertex(v: vertex)
                }
            }
            if item.count == 2 {
                if let from = item[0] as? AnyHashable,
                   let to = item[1] as? AnyHashable {
                    graph.addEdge(from: from, to: to, weight: 1.0)
                }
            }
            if item.count == 3 {
                if let from = item[0] as? AnyHashable,
                   let to = item[1] as? AnyHashable,
                   let weight = item[2] as? NSNumber {
                    graph.addEdge(from: from, to: to, weight: weight.doubleValue)
                }
            }
        }
        return graph
    }
    
    // 无向图
    static func undirectedGraph(_ data: [[Any]]) -> Graph<AnyHashable, Double, DefaultWeightManager<Double>> {
        let graph = Graph<AnyHashable, Double, DefaultWeightManager>(weightManager: DefaultWeightManager<Double>())
        for item in data {
            if item.count == 1 {
                if let vertex = item[0] as? AnyHashable {
                    graph.addVertex(v: vertex)
                }
            }
            if item.count == 2 {
                if let from = item[0] as? AnyHashable,
                   let to = item[1] as? AnyHashable {
                    graph.addEdge(from: from, to: to)
                    graph.addEdge(from: to, to: from)
                }
            }
            if item.count == 3 {
                if let from = item[0] as? AnyHashable,
                   let to = item[1] as? AnyHashable,
                   let weight = item[2] as? NSNumber {
                    graph.addEdge(from: from, to: to, weight: weight.doubleValue)
                    graph.addEdge(from: to, to: from, weight: weight.doubleValue)
                }
            }
        }
        return graph
    }
}
