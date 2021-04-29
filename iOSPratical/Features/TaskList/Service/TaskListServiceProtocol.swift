//
//  TaskListServiceProtocol.swift
//  iOSPratical
//
//  Created by Eduardo Fornari on 29/04/21.
//

import RxSwift

protocol TaskListServiceProtocol {
    func readTasks() -> Observable<[Task]>
}
