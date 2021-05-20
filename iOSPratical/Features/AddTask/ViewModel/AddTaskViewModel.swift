//
//  AddTaskViewModel.swift
//  iOSPratical
//
//  Created by Lucas Saibt Real on 20/04/21.
//

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
        let textInputText: Driver<String?>
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

        let taskText: Driver<String?> = buttonPublisher
            .withLatestFrom(titlePublisher)
            .compactMap { $0 }
            .map { Task($0, false) }
            .do(onNext: {
                addTask($0)
            })
            .map { _ in "" }
            .asDriver { _ in .never() }

        self.input = Input(
            title: titlePublisher,
            button: buttonPublisher
        )

        self.output = Output(
            title: title,
            textInputText: taskText,
            textInputPlaceholder: textInputPlaceholder,
            buttonTitle: buttonTitle
        )
    }

    deinit {
        print("called \(String(describing: AddTaskViewModel.self)) deinit")
    }
}
