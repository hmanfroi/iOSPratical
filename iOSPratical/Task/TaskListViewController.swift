//
//  StartViewController.swift
//  iOSPratical
//
//  Created by Henrique Manfroi on 18/03/21.
//

import UIKit
import RxSwift
import RxDataSources

final class TaskListViewController: UIViewController {
    
    var viewModel: TaskListViewModel

    let titleLabel: UILabel = UILabel()

    let disposeBag = DisposeBag()
    
    private let tableView: UITableView = {
        let tableView = UITableView()
        tableView.backgroundColor = .clear
        tableView.separatorStyle = .none
        tableView.register(TaskTableViewCell.self, forCellReuseIdentifier: TaskTableViewCell.reuseIdentifier)
        tableView.estimatedRowHeight = 120
        tableView.rowHeight = UITableView.automaticDimension
        return tableView
    }()
    
    private let imageView: UIImageView = {
        let imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: 150, height: 150))
        imageView.image = UIImage(named: "splash")
        imageView.tintColor = .primary
        return imageView
    }()
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        imageView.center = view.center
        view.backgroundColor = .white
    }
    
    deinit {
        print("Liberei ViewController")
    }
    
    init(viewModel: TaskListViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupImageLaunch()
        setStates()
        viewModel.getTasks.onNext(())
    }
    
    private func setupImageLaunch(){
        view.addSubview(imageView)
        DispatchQueue.main.asyncAfter(deadline: .now()+0.5, execute: {
            self.animate()
        })
    }
    
    private func setupView(){
        setupLabel()
        setupTableView()
        setupBinds()

        navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "plus.circle"), style: .plain, target: self, action: #selector(addTapped))
        navigationItem.title = viewModel.navigationTitle
    }

    private func setupLabel(){
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(titleLabel)
        titleLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20).isActive = true

        titleLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20).isActive = true
        titleLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 20).isActive = true
        titleLabel.text = viewModel.title
    }

    private func setupTableView() {
        
        tableView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(tableView)

        tableView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 20).isActive = true
        tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor).isActive = true

        tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true

    }
    
    @objc func addTapped(){
        viewModel.addTaskRoute.onNext(())
    }

    private func setupBinds() {
        viewModel.tasksList.bind(to: tableView.rx.items(cellIdentifier: TaskTableViewCell.reuseIdentifier, cellType: TaskTableViewCell.self)) { [weak self] row, event, cell in
            guard let self = self else { return }
            let cellViewModel = CellViewModel(task: event, index: row, viewModel: self.viewModel)
            cell.configure(cellViewModel: cellViewModel)
        }
        .disposed(by: disposeBag)
        
//        tableView.rx.itemSelected.subscribe(onNext: { [weak self] index in
//            guard let self = self else { return }
//            print("estou clicando")
//            self.viewModel.itens[index.row].taskDone.toggle()
//            self.viewModel.tasksList.accept(self.viewModel.itens)
//        }).disposed(by: disposeBag)
        
    }
    
    private func setStates(){
        viewModel.states
            .drive(onNext: { state in
                switch state {
                case .loading:
                    print("loading")
                case .showContent:
                    print("showContent")
                case .error:
                    print("error")
                }
            }).disposed(by: disposeBag)
    }
    
    private func animate(){
        UIView.animate(withDuration: 1, animations: {
            let size = self.view.frame.size.width * 1.5
            let diffX = size - self.view.frame.size.width
            let diffY = self.view.frame.size.height - size

            self.imageView.frame = CGRect(
                x: -(diffX/2),
                y: diffY/2,
                width: size,
                height: size
            )
            
            self.imageView.alpha = 0
        }, completion: { done in
            if done {
                self.setupView()
            }
        })
    }
}
