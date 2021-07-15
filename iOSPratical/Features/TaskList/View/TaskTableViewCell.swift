
import RxCocoa
import RxSwift
import UIKit

final class TaskTableViewCell: UITableViewCell {

    // MARK: - Internal Properties

    static let reuseIdentifier = String(describing: TaskTableViewCell.self)

    // MARK: - Private Properties

    private var disposeBag = DisposeBag()

    private let stackView = UIStackView()
    private let titleLabel = UILabel()
    private let checkButton = UIImageView()

    // MARK: - Initializers

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: .default, reuseIdentifier: reuseIdentifier)
        self.selectionStyle = .none
        setupLayout()
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setupLayout() {
        setupStackView()
        setupLabel()
        setupButton()
    }

    func configure(viewModel: CellViewModel) {
        let output = viewModel.output
        
        output.text
            .drive(titleLabel.rx.attributedText)
            .disposed(by: disposeBag)
        
        output.image
            .map { UIImage(named: $0) }
            .drive(checkButton.rx.image)
            .disposed(by: disposeBag)
        
        output.imageColor
            .map { $0.valueColor }
            .drive(checkButton.rx.tintColor)
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
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        stackView.addSubview(titleLabel)

        titleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20).isActive = true
        titleLabel.centerYAnchor.constraint(equalTo: stackView.centerYAnchor).isActive = true
    }

    private func setupButton(){
        checkButton.translatesAutoresizingMaskIntoConstraints = false
        stackView.addSubview(checkButton)

        checkButton.centerYAnchor.constraint(equalTo: stackView.centerYAnchor).isActive = true
        checkButton.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: 20).isActive = true

        checkButton.widthAnchor.constraint(equalToConstant: 44).isActive = true
        checkButton.heightAnchor.constraint(equalToConstant: 44).isActive = true
    }

}
