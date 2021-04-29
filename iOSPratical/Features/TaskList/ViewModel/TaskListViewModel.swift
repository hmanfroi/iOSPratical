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

    // MARK: - Internal Properties

    let tasksList = BehaviorRelay(value: [Task]())

    let getTasks = PublishSubject<Void>()
    let addTaskRoute = PublishSubject<Void>()

    let navigationTitle = "Suas tarefas"
    let title = "Seja bem vindo"

    // MARK: - Private Properties

    private(set) var states = Driver<TasksStates>.never()
    private(set) var routes = Driver<TasksRoutes>.never()

    // MARK: - Initializers

    init() {
        states = initStates()
        routes = initRoutes()
    }

    deinit {
        print("called \(String(describing: TaskListViewModel.self)) deinit")
    }

    private func readTasks() -> Observable<TasksStates> {
        return TaskListService().readTasks()
            .do(onNext: { [weak self] in
                self?.setTasks(model: $0)
            })
            .map { _ in TasksStates.showContent }
            .catch{ error in
                .just(TasksStates.error)
            }
    }

    func initStates() -> Driver<TasksStates>{
        let requestTasks = getTasks
            .flatMapLatest { [weak self] () -> Observable<TasksStates> in
                guard let self = self else { return .empty() }
                return TaskListService().readTasks()
                    .do(onNext: { [weak self] in
                        self?.setTasks(model: $0)
                    })
                    .map { _ in TasksStates.showContent }
                    .catch{ error in
                        .just(TasksStates.error)
                    }
            }

        return Observable
            .merge(requestTasks)
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
        tasksList.accept(model)
    }

    func changeTask(row: Int) {
        var list = tasksList.value
        list[row].taskDone.toggle()
        tasksList.accept(list)
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


