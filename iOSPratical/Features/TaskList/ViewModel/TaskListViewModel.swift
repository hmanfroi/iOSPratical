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

enum TasksStates {
    case loading
    case showContent
    case error
}

enum TasksRoutes {
    case addTask
}

protocol TaskListViewModelProtocol {
    var tasksList: BehaviorRelay<[Task]> { get }
    var getTasks: PublishSubject<Void> { get }
    var addTaskRoute: PublishSubject<Void> { get }
    
    var navigationTitle: String { get }
    var title: String { get }
    
    var states: Driver<TasksStates> { get }
    var routes: Driver<TasksRoutes> { get }
    
    func initStates() -> Driver<TasksStates>
    func initRoutes() -> Driver<TasksRoutes>
    func changeTask(row: Int)
}

final class TaskListViewModel: TaskListViewModelProtocol {

    // MARK: - Internal Properties

    let tasksList = BehaviorRelay(value: [Task]())

    let getTasks = PublishSubject<Void>()
    let addTaskRoute = PublishSubject<Void>()

    let navigationTitle = "Suas tarefas"
    let title = "Seja bem vindo"

    // MARK: - Private Properties

    private(set) var states = Driver<TasksStates>.never()
    private(set) var routes = Driver<TasksRoutes>.never()
    
    private let service: TaskListServiceProtocol

    // MARK: - Initializers

    init(service: TaskListServiceProtocol = TaskListService()) {
        self.service = service
        
        states = initStates()
        routes = initRoutes()
    }

    deinit {
        print("called \(String(describing: TaskListViewModel.self)) deinit")
    }

    func initStates() -> Driver<TasksStates>{
        let requestTasks = getTasks
            .flatMapLatest { [weak self] () -> Observable<TasksStates> in
                guard let self = self else { return .empty() }
                return self.service.readTasks()
                    .do(onNext: { [weak self] in
                        self?.setTasks(model: $0)
                    })
                    .map { _ in TasksStates.showContent }
                    .catch { error in
                        .just(TasksStates.error)
                    }
            }

        return Observable
            .merge(requestTasks)
            .asDriver(onErrorRecover: { _ in .never() })
    }

    func initRoutes() -> Driver<TasksRoutes> {
        let addTask = addTaskRoute
            .map { _ in
                TasksRoutes.addTask
            }
            .asObservable()

        return Observable
            .merge(addTask)
            .asDriver(onErrorRecover: { _ in .never() })
    }

    func changeTask(row: Int) {
        var list = tasksList.value
        list[row].taskDone.toggle()
        tasksList.accept(list)
    }
    
    private func setTasks(model: [Task]) {
        tasksList.accept(model)
    }
}


