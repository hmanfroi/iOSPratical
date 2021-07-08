//
//  Coordinator.swift
//  iOSPratical
//
//  Created by Lucas Saibt Real on 19/04/21.
//

import Foundation
import UIKit

protocol Coordinator {
    
    var navigationController: UINavigationController { get set }
    
    func start()
}
