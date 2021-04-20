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
    
    func readTasks() -> Observable<[Task]?> {
        if let url = Bundle.main.url(forResource: "tasks", withExtension: "json") {
            do {
                let data = try Data(contentsOf: url)
                let decoder = JSONDecoder()
                let jsonData = try decoder.decode([Task].self, from: data)
                return Observable.just(jsonData)
            } catch let error { 
                return Observable.just(nil)
            }
        }
        return Observable.just(nil)
    }
    
}

extension ObservableType {
    
    public func mapArray<T: Codable>(type: T.Type, data: Data) throws -> Observable<[T]> {
        let decoder = JSONDecoder()
        let objects = try decoder.decode([T].self, from: data)
        return Observable.just(objects)
    }
    
}
