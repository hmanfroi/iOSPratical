//
//  CellViewModel.swift
//  iOSPratical
//
//  Created by Felipe Bayer Weber on 15/04/21.
//

import Foundation

typealias ActionVoid = () -> ()

final class CellViewModel {
    
    var task: Task
    private let action: ActionVoid
    
    deinit {
        print("Liberei CellViewModel")
    }
    
    
    init(task: Task, action: @escaping ActionVoid) {
        self.task = task
        self.action = action
    }
    
}

extension CellViewModel {
    var tapAction: ActionVoid {
        return { [weak self] in self?.action() }
    }
}
