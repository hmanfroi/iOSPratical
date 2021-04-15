//
//  StartViewController.swift
//  iOSPratical
//
//  Created by Henrique Manfroi on 18/03/21.
//

import UIKit
import RxSwift
import RxDataSources

class TaskListViewController: UIViewController {
    
    var viewModel: TaskListViewModel = TaskListViewModel()

    let titleLabel: UILabel = UILabel()

    let tableView = UITableView()
    
    let disposeBag = DisposeBag()
    
    let reuseIdentifier = "toDoCell"

    init() {
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setupLabel()
        setupTable()
        titleLabel.text = viewModel.title
        view.backgroundColor = .white

//        tableView.delegate = self
//        tableView.dataSource = self
        binds()
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "plus.circle"), style: .plain, target: self, action: #selector(addTapped))
        navigationItem.title = viewModel.navigationTitle
    }

    func setupLabel(){
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(titleLabel)
        titleLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20).isActive = true

        titleLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20).isActive = true
        titleLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 20).isActive = true
    }

    func setupTable() {
        
        tableView.backgroundColor = .clear
        
        tableView.separatorStyle = .none
        
        tableView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(tableView)

        tableView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 20).isActive = true
        tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: 0).isActive = true

        tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 0).isActive = true
        tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 0).isActive = true

        tableView.register(TaskTableViewCell.self, forCellReuseIdentifier: reuseIdentifier)
        tableView.estimatedRowHeight = 120
        tableView.rowHeight = UITableView.automaticDimension
    }
    
    @objc func addTapped(){
        self.navigationController?.present(ViewController(), animated: true)
    }

    func binds() {
        viewModel.tasksList.bind(to: tableView.rx.items(cellIdentifier: reuseIdentifier, cellType: TaskTableViewCell.self)) { row, event, cell in
            let cellViewModel = CellViewModel(task: event)
            cell.configure(cellViewModel: cellViewModel)
            //cell.configure(text: event.taskText, checked: event.taskDone)
        }
        .disposed(by: disposeBag)
        
    }
}
