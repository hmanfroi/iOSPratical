//
//  Task.swift
//  iOSPratical
//
//  Created by Alexandre Bing on 08/04/21.
//

import Foundation

struct Task: Decodable {
    var taskText: String
    var taskDone: Bool

    mutating func toggle() {
        taskDone.toggle()
    }
}

extension Task {
    init(_ text: String, _ done: Bool){
        taskText = text
        taskDone = done
    }
}
