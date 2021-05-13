//
//  CellViewModel.swift
//  iOSPratical
//
//  Created by Felipe Bayer Weber on 15/04/21.
//

import Foundation
import RxCocoa
import RxSwift

final class CellViewModel {

    struct Output {
        let text: Driver<NSAttributedString?>
        let image: Driver<String>
        let imageColor: Driver<TDColors>
    }

    // MARK: - Internal Properties

    let output: Output

    // MARK: - Private Properties

    private let action: ActionVoid

    // MARK: - Initializers

    init(task: Task, action: @escaping ActionVoid) {
        self.action = action

        let attributeString =  NSMutableAttributedString(string: task.taskText)
        if task.taskDone {
            attributeString.addAttribute(
                NSAttributedString.Key.strikethroughStyle,
                value: 2,
                range: NSMakeRange(0, attributeString.length)
            )
        }
        let text: Driver<NSAttributedString?> = .just(attributeString)

        let imageChecked = "checked"
        let imageUnchecked = "unchecked"
        let image: Driver<String> = task.taskDone ? .just(imageChecked) : .just(imageUnchecked)

        let imageColor: Driver<TDColors> = task.taskDone ? .just(TDColors.green) : .just(TDColors.black)

        self.output = Output(
            text: text,
            image: image,
            imageColor: imageColor
        )
    }

}

extension CellViewModel {
    var tapAction: ActionVoid {
        return { [weak self] in self?.action() }
    }
}
