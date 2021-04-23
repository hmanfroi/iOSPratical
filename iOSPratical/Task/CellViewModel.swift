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
    var index: Int
//    var viewModel: TaskListViewModel
    private let action: ActionVoid
    
    deinit {
        print("Liberei CellViewModel")
    }
    
//    init(task: Task, index: Int, viewModel: TaskListViewModel) {
//        self.task = task
//        self.index = index
//        self.viewModel = viewModel
//    }
    
    init(task: Task, index: Int, action: @escaping ActionVoid) {
        self.task = task
        self.index = index
        self.action = action
    }
    
//    func changeData() {
//        viewModel.itens[index].taskDone.toggle()
//        viewModel.tasksList.accept(viewModel.itens)
//    }
}

extension CellViewModel {
    var tapAction: ActionVoid {
        return { [weak self] in self?.action() }
    }
}
