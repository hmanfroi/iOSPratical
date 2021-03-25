//
//  TodoViewCell.swift
//  iOSPratical
//
//  Created by Henrique Manfroi on 25/03/21.
//

import UIKit

class TodoViewCell: UITableViewCell {

    let taskLabel: UILabel = UILabel()

    let imageStatus: UIImageView = UIImageView()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: .default, reuseIdentifier: reuseIdentifier)
        setupLabel()
        setupImageStatus()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func configure(text: String, checked: Bool) {
        taskLabel.text = text

        //TODO Update Image
    }

    func setupLabel() {
        taskLabel.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(taskLabel)

        taskLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20).isActive = true
        taskLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 20).isActive = true
        taskLabel.bottomAnchor.constraint(greaterThanOrEqualTo: contentView.bottomAnchor, constant: 20).isActive = true
    }

    func setupImageStatus() {
        imageStatus.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(imageStatus)

        imageStatus.topAnchor.constraint(greaterThanOrEqualTo: contentView.topAnchor, constant: 20).isActive = true
        imageStatus.centerYAnchor.constraint(equalTo: taskLabel.centerYAnchor).isActive = true
        imageStatus.bottomAnchor.constraint(greaterThanOrEqualTo: contentView.bottomAnchor, constant: 20).isActive = true
        imageStatus.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: 20).isActive = true
        imageStatus.leadingAnchor.constraint(lessThanOrEqualTo: taskLabel.trailingAnchor, constant: 20).isActive = true
        imageStatus.widthAnchor.constraint(equalToConstant: 44).isActive = true
        imageStatus.heightAnchor.constraint(equalToConstant: 44).isActive = true
    }
}
