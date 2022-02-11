//
//  UIViewController+Error.swift
//  Social_Network
//
//  Created by Arthur Raff on 10.02.2022.
//

import Foundation
import UIKit

extension UIViewController {
    func showErrorAsAlert(_ error: Error) {
        guard self.isViewLoaded &&
            self.view.window != nil &&
            !self.isBeingPresented &&
            !self.isBeingDismissed &&
            !self.isMovingFromParent &&
            !self.isMovingToParent else {
                return
        }
        
        let alertController = UIAlertController.init(title: nil,
                                                     message: error.localizedDescription,
                                                     preferredStyle: .alert)
        let cancelAction = UIAlertAction.init(title: "OK",
                                              style: .cancel)
        alertController.addAction(cancelAction)
        
        present(alertController,
                animated: true,
                completion: nil)
    }
}
