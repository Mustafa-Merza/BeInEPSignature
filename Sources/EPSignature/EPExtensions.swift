//
//  EPExtensions.swift
//  Pods
//
//  Created by Prabaharan Elangovan on 17/01/16.
//
//

import UIKit

//MARK: - UIViewController Extensions

extension UIViewController {
    
    func showAlert(_ message: String) {
        showAlert(message, andTitle: "", actionTitle: "OK")
    }
    
    func showAlert(_ message: String, andTitle title: String, actionTitle: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertController.Style.alert)
        
        // add an action (button)
        alert.addAction(UIAlertAction(title: actionTitle, style: UIAlertAction.Style.default, handler: nil))
        
        // show the alert
        self.present(alert, animated: true, completion: nil)
    }
}

//MARK: - UIColor Extensions

extension UIColor {
    class func defaultTintColor() -> UIColor {
        return UIColor(red: (233/255), green: (159/255), blue: (94/255), alpha: 1.0)
    }
}

//MARK: - UIImage Extensions

extension UIImage {
    
    static let trash = UIImage(resource: .trashIc)
    static let redo = UIImage(resource: .redoIc)
    static let undo = UIImage(resource: .undoIc)
    static let edit = UIImage(resource: .editIc)
    
    @available(iOS 13.0, *)
    static let back = UIImage(systemName: "chevron.backward")
}
