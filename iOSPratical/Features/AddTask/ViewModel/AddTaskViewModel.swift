
import Foundation
import RxCocoa
import RxSwift

final class AddTaskViewModel {
    struct Input {
        let title: PublishSubject<String?>
        let button: PublishSubject<()>
    }

    struct Output {
        let title: Driver<String?>
        let didAddTask: Driver<Void>
        let textInputPlaceholder: Driver<String?>
        let buttonTitle: Driver<String?>
    }

    // MARK: - Internal Properties

    let input: Input
    let output: Output

    // MARK: - Initializers

    init(taskList: BehaviorRelay<[Task]>){
        let titlePublisher = PublishSubject<String?>()
        let buttonPublisher = PublishSubject<()>()

        let addTask: (Task) -> Void = {
            taskList.accept(taskList.value + [$0])
        }

        let title: Driver<String?> = .just("Adicionar uma tarefa")
        let textInputPlaceholder: Driver<String?> = .just("Título da tarefa")
        let buttonTitle: Driver<String?> = .just("Adicionar")

        let added: Driver<Void> = buttonPublisher
            .withLatestFrom(titlePublisher)
            .compactMap { $0 }
            .map { Task($0, false) }
            .do(onNext: {
                addTask($0)
            })
            .map { _ in () }.asDriver(onErrorDriveWith: .empty())

        self.input = Input(
            title: titlePublisher,
            button: buttonPublisher
        )

        self.output = Output(
            title: title,
            didAddTask: added,
            textInputPlaceholder: textInputPlaceholder,
            buttonTitle: buttonTitle
        )
    }

    deinit {
        print("called \(String(describing: AddTaskViewModel.self)) deinit")
    }
}
