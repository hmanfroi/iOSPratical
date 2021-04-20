//
//  TaskListViewModel.swift
//  iOSPratical
//
//  Created by Alexandre Bing on 08/04/21.
//

import Foundation
import UIKit
import RxSwift
import RxCocoa

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
        print("Liberei TaskListViewModel")
    }
    
    init() {
        states = initStates()
        routes = initRoutes()
    }
    
    func initStates() -> Driver<TasksStates>{
        let requestStatement = getTasks
            .flatMapLatest { [weak self] () -> Observable<TasksStates> in
                guard let self = self else { return .empty() }
                return TaskService().readTasks()
                    .do(onNext: {
                        self.setTasks(model: $0 ?? [Task]())
                    })
                    .map { _ in TasksStates.showContent }
                    .catch { _ in .just(TasksStates.error) }
            }
        
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


