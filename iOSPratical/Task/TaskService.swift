//
//  TaskService.swift
//  iOSPratical
//
//  Created by Lucas Saibt Real on 16/04/21.
//

import Foundation
import RxSwift

final class TaskService {
    
    deinit {
        print("Liberei TaskService")
    }
    
    func readTasks() -> Observable<[Task]> {
        if let url = Bundle.main.url(forResource: "tasks", withExtension: "json") {
            do {
                let data = try Data(contentsOf: url)
                let decoder = JSONDecoder()
                let jsonData = try decoder.decode([Task].self, from: data)
                return Observable.just(jsonData)
            } catch let error {
                print(error)
                return Observable.error(Errors.decodeError)
            }
        }
        return Observable.error(Errors.invalidPath)
    }
    
    enum Errors: Error{
        case invalidPath
        case decodeError
    }
    
}

