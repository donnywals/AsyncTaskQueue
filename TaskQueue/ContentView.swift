//
//  ContentView.swift
//  TaskQueue
//
//  Created by Donny Wals on 16/02/2022.
//

import SwiftUI

struct ContentView: View {
    let queue = DWTaskQueue()
    @State var numberOfTasks = 0.0
    
    var body: some View {
        Slider(value: $numberOfTasks, in: 0.0...1000.0, step: 1.0, label: {
            Text("Number of tasks to add")
        })
        
        Button("Add \(Int(numberOfTasks)) tasks") {
            Task {
                for i in 0..<Int(numberOfTasks) {
                    print("will add task")
                    await queue.addTask({ Task {
                        print("START TASK \(i)")
                        do {
                            try await Task.sleep(nanoseconds: 1_000_000_000 * UInt64.random(in: 0..<2))
                            print("Hello task \(i)")
                        } catch {
                            print(error)
                        }
                    }})
                    print("did add task")
                }
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
