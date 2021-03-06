
import RxSwift
import UIKit

final class TaskListViewController: UIViewController {

    // MARK: - Internal Properties

    let disposeBag = DisposeBag()

    // MARK: - Private Properties

    private let viewModel: TaskListViewModelProtocol

    let navRightButton = UIBarButtonItem(
        image: UIImage(systemName: "plus.circle"),
        style: .plain,
        target: nil,
        action: nil
    )

    private let titleLabel = UILabel()
    private let errorLabel = UILabel()

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
        imageView.tintColor = TDColors.primary.valueColor
        return imageView
    }()

    // MARK: - Initializers

    init(viewModel: TaskListViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setupImageView()
        view.backgroundColor = .white
    }

    private func setupImageView() {
        imageView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(imageView)
        let height = imageView.heightAnchor.constraint(equalToConstant: 150)
        let width = imageView.widthAnchor.constraint(equalToConstant: 150)

        NSLayoutConstraint.activate([
            height,
            width,
            imageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            imageView.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])

        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            UIView.animate(withDuration: 0.7, delay: 0, options: .curveEaseOut) {
                height.constant *= 4
                width.constant *= 4
                self.view.layoutIfNeeded()
            } completion: {
                if $0 {
                    self.imageView.removeFromSuperview()
                    self.setupView()
                    self.setStates()
                    self.viewModel.getTasks.onNext(())
                }
            }
        }
    }

    private func setupView(){
        setupLabel()
        setupTableView()
        setupBinds()

        navigationItem.rightBarButtonItem = navRightButton
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

    private func setupBinds() {
        viewModel.tasksList
            .bind(to: tableView.rx.items(
                cellIdentifier: TaskTableViewCell.reuseIdentifier,
                cellType: TaskTableViewCell.self
            )) { row, task, cell in
                let cellViewModel = CellViewModel(task: task)
                cell.configure(viewModel: cellViewModel)
            }
            .disposed(by: disposeBag)
        
        tableView.rx.itemSelected
            .subscribe(onNext: { indexPath in
                self.viewModel.changeTask(row: indexPath.row)
            })
            .disposed(by: disposeBag)

        navRightButton.rx.tap
            .bind(to: viewModel.addTaskRoute)
            .disposed(by: disposeBag)
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
                    self.setupError()
                }
            }).disposed(by: disposeBag)
    }

    private func setupError() {
        view.addSubview(errorLabel)
        errorLabel.translatesAutoresizingMaskIntoConstraints = false

        errorLabel.text = "Opa, tivemos algum problema!"
        errorLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        errorLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
    }

}
