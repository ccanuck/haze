import Foundation

public protocol MetricsSink: Sendable {
    func incrementCounter(_ name: String, by value: Int64, labels: [String: String]) async
    func recordTiming(_ name: String, durationMs: Double, labels: [String: String]) async
}

public actor InMemoryMetrics: MetricsSink {
    public private(set) var counters: [String: Int64] = [:]
    public private(set) var timings: [String: [Double]] = [:]

    public init() {}

    public func incrementCounter(_ name: String, by value: Int64 = 1, labels: [String: String] = [:]) async {
        let key = metricKey(name, labels: labels)
        counters[key, default: 0] += value
    }

    public func recordTiming(_ name: String, durationMs: Double, labels: [String: String] = [:]) async {
        let key = metricKey(name, labels: labels)
        timings[key, default: []].append(durationMs)
    }

    private func metricKey(_ name: String, labels: [String: String]) -> String {
        let renderedLabels = labels.sorted { $0.key < $1.key }.map { "\($0.key)=\($0.value)" }.joined(separator: ",")
        return renderedLabels.isEmpty ? name : "\(name){\(renderedLabels)}"
    }
}
