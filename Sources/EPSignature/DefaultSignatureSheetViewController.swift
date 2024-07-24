//
//  DefaultSignatureViewController.swift
//
//
//  Created by Mustafa Merza on 7/23/24.
//

import UIKit

protocol DefaultSignatureSheetViewControllerDelegate: AnyObject {
    func useDefaultSignature()
    func deleteDefaultSignature()
}

class DefaultSignatureSheetViewController: UIViewController {
    
    @IBOutlet weak var backgroundView: UIView!
    
    @IBOutlet weak var useDefaultSignatureButton: UIButton!
    @IBOutlet weak var deleteDefaultSignatureButton: UIButton!
    
    weak var delegate: DefaultSignatureSheetViewControllerDelegate?
    
    var useDefaultSignatureButtonTitle: String = ""
    var deleteDefaultSignatureButtonTitle: String = ""
    var backgroundColor: UIColor = .clear
    
    public init(delegate: DefaultSignatureSheetViewControllerDelegate) {
        self.delegate = delegate
        //let bundle = Bundle(for: DefaultSignatureSheetViewController.self)
        super.init(nibName: "DefaultSignatureSheetViewController", bundle: .module)
    }
    
    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    private func setupUI() {
        
        backgroundView.layer.cornerRadius = 30
        backgroundView.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        
        backgroundView.backgroundColor = backgroundColor
        
        useDefaultSignatureButton.setTitle(useDefaultSignatureButtonTitle, for: .normal)
        deleteDefaultSignatureButton.setTitle(deleteDefaultSignatureButtonTitle, for: .normal)
        
        deleteDefaultSignatureButton.tintColor = .red
    }
    
    @IBAction func onTouchUseDefaultSignatureButton(_ sender: Any) {
        delegate?.useDefaultSignature()
        dismiss(animated: true)
    }
    
    @IBAction func onTouchDeleteDefaultSignatureButton(_ sender: Any) {
        delegate?.deleteDefaultSignature()
        dismiss(animated: true)
    }
}
