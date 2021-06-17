//
//  Task.swift
//  iOSPratical
//
//  Created by Alexandre Bing on 08/04/21.
//

import Foundation

struct Task: Decodable, Equatable {
    var taskText: String
    var taskDone: Bool
}

extension Task {
    init(
        _ text: String,
        _ done: Bool = false
    ){
        taskText = text
        taskDone = done
    }
}

