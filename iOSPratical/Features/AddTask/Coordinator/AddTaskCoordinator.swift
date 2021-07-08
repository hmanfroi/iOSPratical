//
//  AddTaskCoordinator.swift
//  iOSPratical
//
//  Created by Lucas Saibt Real on 20/04/21.
//

import Foundation
import RxCocoa
import UIKit
import RxSwift

final class AddTaskCoordinator: Coordinator {

    // MARK: - Internal Properties

    var navigationController: UINavigationController

    // MARK: - Private Properties

    private let taskList: BehaviorRelay<[Task]>

    // MARK: - Initializers

    init(navigationController: UINavigationController, taskList: BehaviorRelay<[Task]>) {
        self.navigationController = navigationController
        self.taskList = taskList
    }

    deinit {
        print("called \(String(describing: AddTaskCoordinator.self)) deinit")
    }

    func start() {
        let viewModel = AddTaskViewModel(taskList: taskList)
        let viewController = AddTaskViewController(viewModel: viewModel)

        navigationController.pushViewController(viewController, animated: true)

        viewModel.output.didAddTask
            .drive(onNext: { [navigationController] _ in
                navigationController.popViewController(animated: true)
            })
            .disposed(by: viewController.disposeBag)
    }

}
