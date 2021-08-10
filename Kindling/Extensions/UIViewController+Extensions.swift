//
//  UIViewController+Extensions.swift
//  Kindling
//
//  Created by Eduardo Bernal on 04/08/21.
//

import Foundation
import UIKit.UIViewController

//MARK: - Easy alert
extension UIViewController {
    func simpleAlert(title: String?, message: String?) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let cancel = UIAlertAction(title: "Got it!", style: .cancel, handler: nil)
        
        alert.view.tintColor = Constants.Color.mainOrange
        alert.addAction(cancel)
        present(alert, animated: true, completion: nil)
    }
}
