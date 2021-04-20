//
//  CellViewModel.swift
//  iOSPratical
//
//  Created by Felipe Bayer Weber on 15/04/21.
//

import Foundation

final class CellViewModel {
    
    var task: Task
    var index: Int
    var viewModel: TaskListViewModel
    
    deinit {
        print("Liberei CellViewModel")
    }
    
    init(task: Task, index: Int, viewModel: TaskListViewModel) {
        self.task = task
        self.index = index
        self.viewModel = viewModel
    }
    
    func changeData() {
        viewModel.itens[index].taskDone.toggle()
        viewModel.tasksList.accept(viewModel.itens)
    }
}
