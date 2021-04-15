//
//  TodoViewCell.swift
//  iOSPratical
//
//  Created by Henrique Manfroi on 25/03/21.
//

import UIKit
import RxSwift
import RxCocoa

class TaskTableViewCell: UITableViewCell {

    let taskLabel: UILabel = UILabel()
    
    var checkButton: UIButton = UIButton()
    
    let stackView = UIStackView()
    
    var checked: Bool = false
    
    let disposeBag = DisposeBag()

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
        
        let text = cellViewModel.task.taskText
        
        self.checked = cellViewModel.task.taskDone
        
        checkButton.setImage(UIImage(systemName: "face.smiling"), for: .normal)
        if checked {
            checkButton.imageView?.tintColor = .systemGreen
            let attributeString: NSMutableAttributedString =  NSMutableAttributedString(string: text)
                attributeString.addAttribute(NSAttributedString.Key.strikethroughStyle, value: 2, range: NSMakeRange(0, attributeString.length))
            taskLabel.attributedText = attributeString
        } else {
            checkButton.imageView?.tintColor = .lightGray
            let attributeString: NSMutableAttributedString =  NSMutableAttributedString(string: text)
            taskLabel.attributedText = attributeString
        }
    }
    

    func configure(text: String, checked: Bool) {
        self.checked = checked
        checkButton.setImage(UIImage(systemName: "face.smiling"), for: .normal)
        if checked {
            checkButton.imageView?.tintColor = .systemGreen
            let attributeString: NSMutableAttributedString =  NSMutableAttributedString(string: text)
                attributeString.addAttribute(NSAttributedString.Key.strikethroughStyle, value: 2, range: NSMakeRange(0, attributeString.length))
            taskLabel.attributedText = attributeString
        } else {
            checkButton.imageView?.tintColor = .lightGray
            let attributeString: NSMutableAttributedString =  NSMutableAttributedString(string: text)
            taskLabel.attributedText = attributeString
        }
    }
    
    func setupStackView() {
        stackView.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(stackView)
        stackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 0).isActive = true
        stackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: 0).isActive = true
        stackView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 0).isActive = true
        stackView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: 0).isActive = true
    }

    func setupLabel() {
        taskLabel.translatesAutoresizingMaskIntoConstraints = false
        stackView.addSubview(taskLabel)

        taskLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20).isActive = true
        taskLabel.centerYAnchor.constraint(equalTo: stackView.centerYAnchor).isActive = true
    }
    
    func setupButton(){
        checkButton.translatesAutoresizingMaskIntoConstraints = false
        stackView.addSubview(checkButton)

        checkButton.centerYAnchor.constraint(equalTo: stackView.centerYAnchor).isActive = true
        checkButton.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20).isActive = true

        checkButton.widthAnchor.constraint(equalToConstant: 44).isActive = true
        checkButton.heightAnchor.constraint(equalToConstant: 44).isActive = true
        
    }
    
    func bindButton() {
        checkButton.rx.tap
            .asDriver()
            .drive(onNext: { [weak self] _ in
                guard let self = self else { return }
                self.configure(text: self.taskLabel.text ?? "", checked: !self.checked)
            })
            .disposed(by: disposeBag)
    }
}
