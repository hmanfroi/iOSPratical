//
//  TodoViewCell.swift
//  iOSPratical
//
//  Created by Henrique Manfroi on 25/03/21.
//

import RxCocoa
import RxSwift
import UIKit

final class TaskTableViewCell: UITableViewCell {

    static let reuseIdentifier = String(describing: TaskTableViewCell.self)

    private let taskLabel = UILabel()

    private let checkButton = UIButton()

    private let stackView = UIStackView()

    private var disposeBag = DisposeBag()

    deinit {
        print("called \(String(describing: TaskTableViewCell.self)) deinit")
    }

    override func prepareForReuse() {
        disposeBag = DisposeBag()
    }

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: .default, reuseIdentifier: reuseIdentifier)
        setupStackView()
        setupLabel()
        setupButton()
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func configure(viewModel: CellViewModel) {
        viewModel.text
            .drive(taskLabel.rx.attributedText)
            .disposed(by: disposeBag)
        viewModel.image
            .drive(checkButton.rx.image(for: .normal))
            .disposed(by: disposeBag)
        viewModel.imageColor
            .drive(checkButton.imageView!.rx.tintColor)
            .disposed(by: disposeBag)
        checkButton.rx.tap
            .asDriver()
            .drive(onNext: {
                viewModel.tapAction()
            })
            .disposed(by: disposeBag)
    }

    private func setupStackView() {
        stackView.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(stackView)
        stackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor).isActive = true
        stackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor).isActive = true
        stackView.topAnchor.constraint(equalTo: contentView.topAnchor).isActive = true
        stackView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor).isActive = true
    }

    private func setupLabel() {
        taskLabel.translatesAutoresizingMaskIntoConstraints = false
        stackView.addSubview(taskLabel)

        taskLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20).isActive = true
        taskLabel.centerYAnchor.constraint(equalTo: stackView.centerYAnchor).isActive = true
    }

    private func setupButton(){
        checkButton.translatesAutoresizingMaskIntoConstraints = false
        stackView.addSubview(checkButton)

        checkButton.centerYAnchor.constraint(equalTo: stackView.centerYAnchor).isActive = true
        checkButton.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20).isActive = true

        checkButton.widthAnchor.constraint(equalToConstant: 44).isActive = true
        checkButton.heightAnchor.constraint(equalToConstant: 44).isActive = true
    }

}
