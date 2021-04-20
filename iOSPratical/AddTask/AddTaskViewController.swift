//
//  ViewController.swift
//  iOSPratical
//
//  Created by Henrique Manfroi on 18/03/21.
//

import UIKit

final class AddTaskViewController: UIViewController {

    var viewModel: AddTaskViewModel
    
    
    init(viewModel: AddTaskViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .systemBlue
    }


}

