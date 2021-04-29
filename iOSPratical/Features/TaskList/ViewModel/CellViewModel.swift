//
//  CellViewModel.swift
//  iOSPratical
//
//  Created by Felipe Bayer Weber on 15/04/21.
//

import Foundation

typealias ActionVoid = () -> ()

final class CellViewModel {

    // MARK: - Internal Properties

    let task: Task

    // MARK: - Private Properties

    private let action: ActionVoid

    // MARK: - Initializers

    init(task: Task, action: @escaping ActionVoid) {
        self.task = task
        self.action = action
    }

    deinit {
        print("called \(String(describing: CellViewModel.self)) deinit")
    }

}

extension CellViewModel {
    var tapAction: ActionVoid {
        return { [weak self] in self?.action() }
    }
}
