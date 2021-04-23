//
//  AddTaskCoordinator.swift
//  iOSPratical
//
//  Created by Lucas Saibt Real on 20/04/21.
//

import Foundation
import UIKit

class AddTaskCoordinator: Coordinator {
    
    var navigationController: UINavigationController
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    deinit {
        print("liberei AddTaskCoordinator")
    }

    func start() {
        let viewModel = AddTaskViewModel()
        let viewController = AddTaskViewController(viewModel: viewModel)

        navigationController.pushViewController(viewController, animated: true)
    }
    
}

