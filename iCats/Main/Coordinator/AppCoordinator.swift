//
//  AppCoordinator.swift
//  iCats
//
//  Created by Yuri on 13/06/20.
//  Copyright © 2020 DevVenture. All rights reserved.
//

import UIKit

class AppCoordinator: Coordinator {
    var navigationController: UINavigationController
    
    var childCoordinators: [Coordinator] = []
    
    var parentCoordinator: Coordinator?
    
    init() {
        navigationController = UINavigationController()
        navigationController.navigationBar.prefersLargeTitles = true
    }
    
    func start() {
        let childCoordinator = CatsCoordinator(with: navigationController)
        childCoordinator.parentCoordinator = self
        add(childCoordinator)
        childCoordinator.start()
    }
    
    func back() {
        
    }
}
