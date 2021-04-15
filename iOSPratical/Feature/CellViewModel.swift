//
//  CellViewModel.swift
//  iOSPratical
//
//  Created by Felipe Bayer Weber on 15/04/21.
//

import Foundation

final class CellViewModel {
    
    var task: Task
    
    init(task: Task) {
        self.task = task
    }
    
    func toggleTask() {
        task.taskDone.toggle()
    }
}
