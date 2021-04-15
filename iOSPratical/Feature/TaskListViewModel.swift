//
//  TaskListViewModel.swift
//  iOSPratical
//
//  Created by Alexandre Bing on 08/04/21.
//

import Foundation
import RxSwift

class TaskListViewModel {
    
    var tasksList: Observable<[Task]>
    
    let navigationTitle = "TO DO LIST"
    
    let title = "Seja bem vindo"
    
    
//    func getTask(for row: Int) -> (String, Bool) {
//        let task = MockTests().tasks[row]
//        return (task.taskText, task.taskDone)
//    }
    
//    func toggleTaskStatus(for index: Int){
//        tasks[index].taskDone.toggle()
//    }
    
    init() {
        tasksList = Observable.just(MockTests().tasks)
    }
}
