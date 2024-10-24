//
//  PerformanceAdapter.swift
//  FluxSwift
//
//  Created by ShuZik on 23.03.2024.
//
//  For future...

/*
import FirebasePerformance
import Foundation

final class PerformanceAdapter {
    private static let sharedInstance = PerformanceAdapter()
    private let performance: Performance
    private var traceDict: [String: Trace]

    private init(performance: Performance = Performance.sharedInstance()) {
        FirebaseAdapter.setup()
        self.performance = performance
        self.traceDict = [:]

        let finalEnabled = !AppEnvironment.isDebug
        performance.isInstrumentationEnabled = finalEnabled
        performance.isDataCollectionEnabled = finalEnabled
    }

    // MARK: - Public

    static var shared: PerformanceAdapter {
        return sharedInstance
    }

    /// has to be closed
    func startTrace(_ eventName: String) {
        if traceDict[eventName] != nil {
            #if DEBUG
                fatalError("Error while adding trace: Trace already exists")
            #endif
            return
        } else {
            guard let trace = Performance.startTrace(name: eventName) else {
                print("⚠️ Error while adding trace: Init failed")
                return
            }

            traceDict[eventName] = trace
        }
    }

    func stopTrace(_ eventName: String) {
        guard let trace = traceDict[eventName] else {
            return
        }

        trace.stop()
        traceDict.removeValue(forKey: eventName)
    }
}
*/
