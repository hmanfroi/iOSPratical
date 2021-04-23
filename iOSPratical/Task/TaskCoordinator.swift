//
//  MainCoordinator.swift
//  iOSPratical
//
//  Created by Lucas Saibt Real on 19/04/21.
//

import Foundation
import RxSwift
import UIKit

class TaskCoordinator: Coordinator {
    
    var navigationController: UINavigationController
    var dispose = DisposeBag()
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    deinit {
        print("liberei Coordinator")
    }

    func start() {
        let viewModel = TaskListViewModel()
        let viewController = TaskListViewController(viewModel: viewModel)

        viewModel.routes
        .filter { $0 == .addTask }
        .drive(onNext: { [initAddTask] _ in
            initAddTask()
        }).disposed(by: viewController.disposeBag)

        navigationController.pushViewController(viewController, animated: true)
    }
    
    
    func initAddTask() {
        AddTaskCoordinator(navigationController: navigationController).start()
    }
}

