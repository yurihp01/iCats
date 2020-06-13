//
//  Coordinator.swift
//  iCats
//
//  Created by Yuri on 12/06/20.
//  Copyright © 2020 DevVenture. All rights reserved.
//

import UIKit

protocol Coordinator: class {
    var navigationController: UINavigationController { get set }
    var childCoordinators: [Coordinator] { get set }
    var parentCoordinator: Coordinator? { get set }
    
    func start()
    func stop()
    func add(_ coordinator: Coordinator)
    func remove(_ coordinator: Coordinator)
    func back()
    func childDidFinish(_ child: Coordinator?)
}

extension Coordinator {
    func add(_ coordinator: Coordinator) {
        childCoordinators.append(coordinator)
    }
    
    func remove(_ coordinator: Coordinator) {
        childCoordinators.removeAll(where: { $0 === coordinator })
    }
    
    func childDidFinish(_ child: Coordinator?) {
        guard let child = child else { return }
        remove(child)
    }
    
    func back() {}
    
    func stop() {}
}
