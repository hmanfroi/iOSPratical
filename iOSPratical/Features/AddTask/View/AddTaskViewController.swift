
import RxSwift
import UIKit

final class AddTaskViewController: UIViewController {

    // MARK: Internal variables

    var disposeBag = DisposeBag()

    // MARK: - Private Properties

    private let viewModel: AddTaskViewModel
    private let titleLabel = UILabel()
    private let taskTextField = UITextField()
    private let taskButton = UIButton()

    // MARK: - Initializers

    init(viewModel: AddTaskViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        setupTitleLabel()
        setupTaskTextField()
        setupTaskButton()
        bindInputs()
        bindOutputs()
    }

    private func bindInputs() {
        let input = viewModel.input
        
        taskTextField.rx.text
            .bind(to: input.title)
            .disposed(by: disposeBag)
        
        taskButton.rx.tap
            .bind(to: input.button)
            .disposed(by: disposeBag)
    }

    private func bindOutputs() {
        let output = viewModel.output
        
        titleLabel.text = "Titulo errado"
        
        output.textInputPlaceholder
            .drive(taskTextField.rx.placeholder)
            .disposed(by: disposeBag)
        
        output.buttonTitle
            .drive(taskButton.rx.title(for: .normal))
            .disposed(by: disposeBag)
    }

    private func setupTitleLabel() {
        view.addSubview(titleLabel)

        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 20).isActive = true
        titleLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20).isActive = true
        titleLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 20).isActive = true
    }

    private func setupTaskTextField() {
        view.addSubview(taskTextField)

        taskTextField.translatesAutoresizingMaskIntoConstraints = false
        taskTextField.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 20).isActive = true
        taskTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20).isActive = true
        taskTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20).isActive = true

        taskTextField.layer.borderWidth = 1
        taskTextField.layer.borderColor = UIColor.gray.cgColor
    }

    private func setupTaskButton() {
        view.addSubview(taskButton)

        taskButton.translatesAutoresizingMaskIntoConstraints = false
        taskButton.topAnchor.constraint(equalTo: taskTextField.bottomAnchor, constant: 20).isActive = true
        taskButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20).isActive = true
        taskButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20).isActive = true

        taskButton.backgroundColor = .green
        taskButton.setTitleColor(.black, for: .normal)
    }

}

