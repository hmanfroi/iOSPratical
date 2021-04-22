//
//  ViewController.swift
//  iOSPratical
//
//  Created by Henrique Manfroi on 18/03/21.
//

import UIKit

final class AddTaskViewController: UIViewController {

    var viewModel: AddTaskViewModel
    let titleLabel: UILabel = UILabel()
    let taskTextField: UITextField = UITextField()
    let taskButton: UIButton = UIButton()

    init(viewModel: AddTaskViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setupTitleLabel()
        setupTaskTextField()
        setupTaskButton()
    }
    
    private func setupTitleLabel() {
        view.addSubview(titleLabel)
        
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 74).isActive = true
        titleLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20).isActive = true
        titleLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 20).isActive = true
        
        titleLabel.text = "Adicionar uma tarefa"
    }

    private func setupTaskTextField() {
        view.addSubview(taskTextField)
        
        taskTextField.translatesAutoresizingMaskIntoConstraints = false
        taskTextField.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 20).isActive = true
        taskTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20).isActive = true
        taskTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20).isActive = true
        
        taskTextField.placeholder = "Título da tarefa"
        taskTextField.layer.borderWidth = 1
        taskTextField.layer.borderColor = UIColor.gray.cgColor
    }
    
    private func setupTaskButton() {
        view.addSubview(taskButton)
        
        taskButton.translatesAutoresizingMaskIntoConstraints = false
        taskButton.topAnchor.constraint(equalTo: taskTextField.bottomAnchor, constant: 20).isActive = true
        taskButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20).isActive = true
        taskButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20).isActive = true
        
        taskButton.setTitle("Adicionar tarefa", for: .normal)
        taskButton.backgroundColor = .green
        taskButton.setTitleColor(.black, for: .normal)
        taskButton.addTarget(self, action: #selector(addTask), for: .touchUpInside)
    }
    
    @objc private func addTask() {
        print("adicionei")
    }
}

