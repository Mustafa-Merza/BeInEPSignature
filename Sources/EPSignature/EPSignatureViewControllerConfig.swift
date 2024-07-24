//
//  EPSignatureViewControllerConfig.swift
//
//
//  Created by Mustafa Merza on 7/23/24.
//

import UIKit

public struct EPSignatureViewControllerConfig {
    
    let colors: EPSignatureViewControllerColor
    
    let titles: EPSignatureViewControllerTitle
    
    public init(colors: EPSignatureViewControllerColor, titles: EPSignatureViewControllerTitle) {
        self.colors = colors
        self.titles = titles
    }
}

public struct EPSignatureViewControllerColor {
    
    let backgroundColor: UIColor
    let toolbarTintColor: UIColor
    let signatureBorderColor: UIColor
    let switchColor: UIColor
    let saveButtonColor: UIColor
    let defaultSignatureButtonColor: UIColor
    
    public init(backgroundColor: UIColor,
                toolbarTintColor: UIColor,
                signatureBorderColor: UIColor,
                switchColor: UIColor,
                saveButtonColor: UIColor,
                defaultSignatureButtonColor: UIColor) {
        self.backgroundColor = backgroundColor
        self.toolbarTintColor = toolbarTintColor
        self.signatureBorderColor = signatureBorderColor
        self.switchColor = switchColor
        self.saveButtonColor = saveButtonColor
        self.defaultSignatureButtonColor = defaultSignatureButtonColor
    }
}

public struct EPSignatureViewControllerTitle {
    
    let backButtonTitle: String
    let saveButtonTitle: String
    let saveToDefaultSignatureSwitchTitle: String
    let defaultSignatureButtonTitle: String
    
    let useDefaultSignatureButtonTitle: String
    let deleteDefaultSignatureButtonTitle: String
    
    let didntSignAlertTitle: String
    let didntSignAlertMessage: String
    let didntSignAlertActionTitle: String
    
    public init(backButtonTitle: String,
                saveButtonTitle: String,
                saveToDefaultSignatureSwitchTitle: String,
                defaultSignatureButtonTitle: String,
                useDefaultSignatureButtonTitle: String,
                deleteDefaultSignatureButtonTitle: String,
                didntSignAlertTitle: String,
                didntSignAlertMessage: String,
                didntSignAlertActionTitle: String) {
        self.backButtonTitle = backButtonTitle
        self.saveButtonTitle = saveButtonTitle
        self.saveToDefaultSignatureSwitchTitle = saveToDefaultSignatureSwitchTitle
        self.defaultSignatureButtonTitle = defaultSignatureButtonTitle
        self.useDefaultSignatureButtonTitle = useDefaultSignatureButtonTitle
        self.deleteDefaultSignatureButtonTitle = deleteDefaultSignatureButtonTitle
        self.didntSignAlertTitle = didntSignAlertTitle
        self.didntSignAlertMessage = didntSignAlertMessage
        self.didntSignAlertActionTitle = didntSignAlertActionTitle
    }
}
