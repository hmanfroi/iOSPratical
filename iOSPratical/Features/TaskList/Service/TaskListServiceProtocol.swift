
import RxSwift

protocol TaskListServiceProtocol {
    func readTasks() -> Observable<[Task]>
}
