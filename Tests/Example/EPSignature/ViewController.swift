//
//  ViewController.swift
//  EPSignature
//
//  Created by Prabaharan on 01/13/2016.
//  Modified By C0mrade on 27/09/2016.
//  Copyright (c) 2016 Prabaharan. All rights reserved.
//

import UIKit
import EPSignature

class ViewController: UIViewController, EPSignatureDelegate {
    @IBOutlet weak var imgWidthConstraint: NSLayoutConstraint!
    @IBOutlet weak var imgHeightConstraint: NSLayoutConstraint!
    @IBOutlet weak var imgViewSignature: UIImageView!

    @IBAction func onTouchSignatureButton(sender: AnyObject) {
        
        let colors = EPSignatureViewControllerColor(backgroundColor: .white, toolbarTintColor: .black, buttonsTintColor: .black, signatureBorderColor: .black, switchColor: .blue, saveButtonColor: .blue, defaultSignatureButtonColor: .orange)
        
        let titles = EPSignatureViewControllerTitle(backButtonTitle: "Signature", deleteSignatureButtonTitle: "Delete signature", rotateLeftButtonTitle: "Rotate left", rotateRightButtonTitle: "Rotate right", saveButtonTitle: "Save", saveSignatureSwitchTitle: "Save signature", defaultSignatureButtonTitle: "Default signature", useDefaultSignatureButtonTitle: "Use default signature", deleteDefaultSignatureButtonTitle: "Delete default signature", didntSignAlertTitle: "You didnt sign", didntSignAlertMessage: "please sign", didntSignAlertActionTitle: "Ok")
        
        let config = EPSignatureViewControllerConfig(colors: colors, titles: titles)
        
        let signatureVC = EPSignatureViewController(signatureDelegate: self, config: config)
        
        let nav = UINavigationController(rootViewController: signatureVC)
        nav.modalPresentationStyle = .fullScreen
        present(nav, animated: true, completion: nil)
    }

    func epSignature(_: EPSignatureViewController, didCancel error : NSError) {
        print("User canceled")
    }
    
    func epSignature(_: EPSignatureViewController, didSign signatureImage : UIImage, boundingRect: CGRect) {
        print(signatureImage)
        imgViewSignature.image = signatureImage
        imgWidthConstraint.constant = boundingRect.size.width
        imgHeightConstraint.constant = boundingRect.size.height
    }

}

