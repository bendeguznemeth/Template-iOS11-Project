//
//  UIViewController+Extension.swift
//  Template-iOS11-Project
//
//  Created by Németh Bendegúz on 2020. 03. 13..
//  Copyright © 2020. Németh Bendegúz. All rights reserved.
//

import UIKit

extension UIViewController {
    func presentAlert(withTitle title: String?, withMessage message: String?, withButtonTitle buttonTitle: String?, withButtonHandler buttonHandler: (() -> Void)? = nil) {
        let alertController = UIAlertController(title: title,
                                                message: message,
                                                preferredStyle: .alert)
        let dismissAction = UIAlertAction(title: buttonTitle,
                                          style: .default,
                                          handler: ({ (_) in
                                            buttonHandler?()
                                          }))
        alertController.addAction(dismissAction)
        self.present(alertController, animated: true, completion: nil)
    }
    
    func presentError(_ error: Error, withButtonHandler buttonHandler: (() -> Void)? = nil) {
        presentAlert(withTitle: "Error occurred",
                     withMessage: error.localizedDescription,
                     withButtonTitle: "OK",
                     withButtonHandler: buttonHandler)
    }
}
