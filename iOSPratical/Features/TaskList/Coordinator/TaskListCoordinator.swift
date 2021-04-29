//
//  MainCoordinator.swift
//  iOSPratical
//
//  Created by Lucas Saibt Real on 19/04/21.
//

import Foundation
import RxSwift
import UIKit

final class TaskListCoordinator: Coordinator {

    // MARK: - Internal Properties

    var navigationController: UINavigationController

    // MARK: - Private Properties

    private let viewModel = TaskListViewModel()

    // MARK: - Initializers

    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }

    deinit {
        print("called \(String(describing: TaskListCoordinator.self)) deinit")
    }

    func start() {
        let viewController = TaskListViewController(viewModel: viewModel)

        viewModel.routes
        .filter { $0 == .addTask }
        .drive(onNext: { [initAddTask] _ in
            initAddTask()
        }).disposed(by: viewController.disposeBag)

        navigationController.pushViewController(viewController, animated: true)
    }

    func initAddTask() {
        let coordinator = AddTaskCoordinator(
            navigationController: navigationController,
            taskList: viewModel.tasksList
        )
        coordinator.start()
    }
}

