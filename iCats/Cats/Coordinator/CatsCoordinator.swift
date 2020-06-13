//
//  CatsCoordinator.swift
//  iCats
//
//  Created by Yuri on 13/06/20.
//  Copyright © 2020 DevVenture. All rights reserved.
//

import UIKit

class CatsCoordinator: Coordinator {
    var navigationController: UINavigationController
    
    var childCoordinators: [Coordinator] = []
    
    var parentCoordinator: Coordinator?
    
    init(with navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        let viewController = UIStoryboard(name: "Cats", bundle: nil).instantiateViewController(withIdentifier: "CatsViewController") as! CatsViewController
        viewController.viewModel = CatsViewModel()
        viewController.coordinator = self
        navigationController.pushViewController(viewController, animated: true)
    }
}
