//
//  DWTaskQueue.swift
//  TaskQueue
//
//  Created by Donny Wals on 16/02/2022.
//

import Foundation
import Combine

typealias TaskProducer = () -> Task<Void, Never>

actor DWTaskQueue {
    private var taskProducers = [TaskProducer]()
    private var isProcessingTasks = false
    
    init() { }
    
    func addTask(_ producer: @escaping TaskProducer) {
        taskProducers.append(producer)
        
        if !isProcessingTasks {
            runTaskLoop()
        }
    }
    
    private func runTaskLoop() {
        isProcessingTasks = true
        Task {
            while !taskProducers.isEmpty {
                let taskProducer = taskProducers.removeFirst()
                let task = taskProducer()
                _ = await task.value
            }
            
            isProcessingTasks = false
        }
    }
}
