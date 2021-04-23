//
//  CellViewModel.swift
//  iOSPratical
//
//  Created by Felipe Bayer Weber on 15/04/21.
//

import Foundation
import RxCocoa
import RxSwift

typealias ActionVoid = () -> ()
typealias CellViewModelAction = () -> Bool

final class CellViewModel {

    // MARK: Internal Properties

    private let task: Task

    private lazy var doneSubject: BehaviorSubject<Bool> = {
        return BehaviorSubject<Bool>(value: task.taskDone)
    }()

    lazy var text: Driver<NSAttributedString?> = {
        let attributeString = NSMutableAttributedString(string: task.taskText)
        let strikethroughStyle: Observable<NSAttributedString?> = doneSubject
            .filter { $0 }
            .map { _ in
                attributeString.addAttribute(
                    .strikethroughStyle,
                    value: 2,
                    range: NSMakeRange(0, attributeString.length)
                )
                return attributeString
            }
        let normalStyle: Observable<NSAttributedString?> = doneSubject
            .filter { !$0 }
            .map { _ in attributeString }
        let style = Observable.merge(normalStyle, strikethroughStyle)
        return style.asDriver(onErrorRecover: { _ in .never() })
    }()

    
    lazy var image: Driver<UIImage?> = {
        let checked: Observable<UIImage?> = doneSubject
            .filter { $0 }
            .map { _ in UIImage(named: "checked")?.withTintColor(#colorLiteral(red: 0.3411764801, green: 0.6235294342, blue: 0.1686274558, alpha: 1)) }
        let unchecked: Observable<UIImage?> = doneSubject
            .filter { !$0 }
            .map { _ in UIImage(named: "unchecked") }

        return Observable.merge(checked, unchecked)
            .asDriver(onErrorRecover: { _ in .never() })
    }()

    lazy var imageColor: Driver<UIColor> = {
        let checked: Observable<UIColor> = doneSubject
            .filter { $0 }
            .map { _ in .systemGreen }
        let unchecked: Observable<UIColor> = doneSubject
            .filter { !$0 }
            .map { _ in .black }

        return Observable.merge(checked, unchecked)
            .asDriver(onErrorRecover: { _ in .never() })
    }()

    var done: Driver<Bool> {
        doneSubject.asDriver { _ in .never() }
    }

    // MARK: Private Properties

    private let action: CellViewModelAction

    // MARK: - Initializers

    init(task: Task, action: @escaping CellViewModelAction) {
        self.task = task
        self.action = action
    }

    deinit {
        print("called \(String(describing: CellViewModel.self)) deinit")
    }

}

extension CellViewModel {
    var tapAction: ActionVoid {
        return { [weak self] in
            guard let self = self else { return }
            let state = self.action()
            self.doneSubject.onNext(state)
        }
    }
}
