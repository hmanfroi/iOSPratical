//
//  TodoViewCell.swift
//  iOSPratical
//
//  Created by Henrique Manfroi on 25/03/21.
//

import UIKit
import RxSwift
import RxCocoa

final class TaskTableViewCell: UITableViewCell {
    
    static let reuseIdentifier = "TaskTableViewCell"

    var taskLabel: UILabel = UILabel()
    
    var checkButton: UIButton = UIButton()
    
    let stackView = UIStackView()
    
    let disposeBag = DisposeBag()
    
    var viewModel : CellViewModel?
    
    deinit {
        print("Liberei TaskTableViewCell")
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: .default, reuseIdentifier: reuseIdentifier)
        setupStackView()
        setupLabel()
        setupButton()
        bindButton()
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(cellViewModel: CellViewModel) {
        viewModel = cellViewModel
        let text = cellViewModel.task.taskText
        let taskDone = cellViewModel.task.taskDone
        let attributeString: NSMutableAttributedString =  NSMutableAttributedString(string: text)
        if taskDone {
            attributeString.addAttribute(NSAttributedString.Key.strikethroughStyle, value: 2, range: NSMakeRange(0, attributeString.length))
        }
        taskLabel.attributedText = attributeString
        setImage(taskDone: taskDone)
    }
    
    private func setImage(taskDone: Bool){
        let imageName = taskDone ? "checked" : "unchecked"
        checkButton.setImage(UIImage(named: imageName), for: .normal)
        checkButton.imageView?.tintColor = taskDone ? .systemGreen : .black
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
    
    private func bindButton() {
        checkButton.rx.tap
            .asDriver()
            .drive(onNext: { [weak self] _ in
                guard let self = self else { return }
                self.viewModel?.tapAction()
            })
            .disposed(by: disposeBag)
    }
    
}
