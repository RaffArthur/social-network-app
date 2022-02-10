//
//  ErrorsAlert.swift
//  Social_Network
//
//  Created by Arthur Raff on 03.04.2021.
//

import UIKit

class ErrorsAlert {
    class func showErrorsAlert(title: String, message: String, on vc: UIViewController) {
        
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let action = UIAlertAction(title: "OK", style: .destructive, handler: nil)
        
        alert.addAction(action)
        
        vc.present(alert, animated: true, completion: nil)
    }
}
