//
//  TaskListViewModel.swift
//  iOSPratical
//
//  Created by Alexandre Bing on 08/04/21.
//

import Foundation
import RxCocoa
import RxSwift
import UIKit

final class TaskListViewModel {
    var tasksList = BehaviorRelay(value: [Task]())
    var itens = [Task]()
    var activityIndicator = PublishSubject<Void>()
    var getTasks = PublishSubject<Void>()
    var addTaskRoute = PublishSubject<Void>()
    
    private(set) var states = Driver<TasksStates>.never()
    private(set) var routes = Driver<TasksRoutes>.never()
    
    let navigationTitle = "Suas tarefas"
    let title = "Seja bem vindo"

    deinit {
        print("called \(String(describing: TaskListViewModel.self)) deinit")
    }

    init() {
        states = initStates()
        routes = initRoutes()
    }
    
    private func readTasks() -> Observable<TasksStates> {
        return TaskService().readTasks()
            .do(onNext: { [weak self] in
                self?.setTasks(model: $0)
            })
            .map { _ in TasksStates.showContent }
            .catch{ error in
                .just(TasksStates.error)
            }
    }

    func initStates() -> Driver<TasksStates>{
        let requestStatement = getTasks
            .flatMapLatest(readTasks)
        
        return Observable
            .merge(requestStatement)
            .asDriver(onErrorRecover: { _ in .never() })
    }
    
    func initRoutes() -> Driver<TasksRoutes>{
        let addTask = addTaskRoute
            .map { _ in
                TasksRoutes.addTask
            }
            .asObservable()
        
        return Observable
            .merge(addTask)
            .asDriver(onErrorRecover: { _ in .never() })
    }
    
    private func setTasks(model: [Task]) {
        itens = model
        tasksList.accept(itens)
    }
    
    enum TasksStates {
        case loading
        case showContent
        case error
    }
    
    enum TasksRoutes {
        case addTask
    }
}


