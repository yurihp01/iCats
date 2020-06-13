//
//  CatsAlert.swift
//  iCats
//
//  Created by Yuri on 13/06/20.
//  Copyright © 2020 DevVenture. All rights reserved.
//

import UIKit

final class CatsAlert {
    private init() {}
    
    static func showAlertDialog(title: String, message: String) -> UIAlertController {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let action = UIAlertAction(title: "OK", style: .default, handler: nil)
        alert.addAction(action)
        return alert
    }
}
