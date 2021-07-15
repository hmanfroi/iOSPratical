
import Foundation
import RxSwift

final class TaskListService: TaskListServiceProtocol {
    enum Errors: Error {
        case invalidPath
        case decodeError
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

}

