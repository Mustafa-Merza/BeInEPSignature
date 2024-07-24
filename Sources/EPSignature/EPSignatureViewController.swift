//
//  EPSignatureViewController.swift
//  Pods
//
//  Created by Prabaharan Elangovan on 13/01/16.
//
//

import UIKit
import NBBottomSheet

// MARK: - EPSignatureDelegate
@objc public protocol EPSignatureDelegate {
    @objc optional func epSignature(_: EPSignatureViewController, didCancel error : NSError)
    @objc optional func epSignature(_: EPSignatureViewController, didSign signatureImage : UIImage, boundingRect: CGRect)
}

open class EPSignatureViewController: UIViewController, DefaultSignatureSheetViewControllerDelegate {
    
    // MARK: - IBOutlets
    
    @IBOutlet weak var switchSaveSignature: UISwitch!
    @IBOutlet weak var lblDefaultSignature: UILabel!
    @IBOutlet weak var signatureBackgroundView: UIView!
    @IBOutlet weak var signatureView: EPSignatureView!
    @IBOutlet weak var saveToDefaultsView: UIStackView!
    @IBOutlet weak var saveButton: UIButton!
    @IBOutlet weak var defaultSignatureButton: UIButton!
    
    // MARK: - Public Vars
    
    open var config: EPSignatureViewControllerConfig
    open weak var signatureDelegate: EPSignatureDelegate?
    
    // MARK: - Life cycle methods
    
    override open func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    override open func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - Initializers
    
    public init(signatureDelegate: EPSignatureDelegate,
                config: EPSignatureViewControllerConfig) {
        
        self.signatureDelegate = signatureDelegate
        self.config = config
        //let bundle = Bundle(for: EPSignatureViewController.self)
        super.init(nibName: "EPSignatureViewController", bundle: .module)
    }
    
    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - UI Setup
    
    private lazy var userHasDefaultSignatureExists: Bool = {
        defaultSignatureExists()
    }()
    
    private lazy var cancelButton: UIBarButtonItem = {
        
        let button = UIButton(type: .system)
        
        if #available(iOS 13.0, *) {
            button.setImage(.back, for: .normal)
        }
        
        button.setTitle(config.titles.backButtonTitle, for: .normal)
        
        button.addTarget(self,
                         action: #selector(EPSignatureViewController.onTouchCancelButton),
                         for: .touchUpInside)
        
        button.tintColor = config.colors.toolbarTintColor
        
        return UIBarButtonItem(customView: button)
    }()
    
    private lazy var clearButton: UIBarButtonItem = {
        let button = UIBarButtonItem(image: .trash,
                                     style: .done,
                                     target: self,
                                     action: #selector(EPSignatureViewController.onTouchClearButton))
        
        button.tintColor = .red
        
        return button
    }()
    
    private lazy var redoButton: UIBarButtonItem = {
        let button = UIBarButtonItem(image: .redo,
                                     style: .done,
                                     target: self,
                                     action: #selector(EPSignatureViewController.onTouchRedoButton))
        
        button.tintColor = config.colors.toolbarTintColor
        
        return button
    }()
    
    private lazy var undoButton: UIBarButtonItem = {
        let button = UIBarButtonItem(image: .undo,
                                     style: .done,
                                     target: self,
                                     action: #selector(EPSignatureViewController.onTouchUndoButton))
        
        button.tintColor = config.colors.toolbarTintColor
        
        return button
    }()
    
    private lazy var editButton: UIBarButtonItem = {
        let button = UIBarButtonItem(image: .edit,
                                     style: .done,
                                     target: self,
                                     action: #selector(EPSignatureViewController.onTouchEditButton))
        
        button.tintColor = config.colors.toolbarTintColor
        
        return button
    }()
    
    private func setupUI() {
        
        setupToolbar()
        
        view.backgroundColor = config.colors.backgroundColor
        
        signatureBackgroundView.layer.borderColor = config.colors.signatureBorderColor.cgColor
        signatureBackgroundView.layer.borderWidth = 1
        signatureBackgroundView.layer.cornerRadius = 5
        
        saveButton.setTitle(config.titles.saveButtonTitle, for: .normal)
        defaultSignatureButton.setTitle(config.titles.defaultSignatureButtonTitle, for: .normal)
        
        lblDefaultSignature.text = config.titles.saveToDefaultSignatureSwitchTitle
        
        saveButton.tintColor = config.colors.saveButtonColor
        defaultSignatureButton.tintColor = config.colors.defaultSignatureButtonColor
        switchSaveSignature.onTintColor = config.colors.switchColor
        
        switchSaveSignature.setOn(false, animated: true)
        
        setupDefaultSignatureViews()
    }
    
    private func setupDefaultSignatureViews() {
        saveToDefaultsView.isHidden = userHasDefaultSignatureExists
        defaultSignatureButton.isHidden = !userHasDefaultSignatureExists
    }
    
    private func setupToolbar() {
        
        self.navigationItem.leftBarButtonItem = cancelButton
        
        if userHasDefaultSignatureExists {
            navigationItem.rightBarButtonItems = [clearButton, editButton]
        }
        else {
            navigationItem.rightBarButtonItems = [clearButton, undoButton, redoButton]
        }
    }
    
    // MARK: - Button Actions
    
    @IBAction func onTouchDefaultSignatureButton(_ sender: Any) {
        
        let popup = DefaultSignatureSheetViewController(delegate: self)
        
        popup.useDefaultSignatureButtonTitle = config.titles.useDefaultSignatureButtonTitle
        popup.deleteDefaultSignatureButtonTitle = config.titles.deleteDefaultSignatureButtonTitle
        popup.backgroundColor = config.colors.backgroundColor
        
        let viewHeight = popup.view.frame.height
        
        let configuration = NBBottomSheetConfiguration(animationDuration: 0.4, sheetSize: .fixed(viewHeight))
        
        let bottomSheetController = NBBottomSheetController(configuration: configuration)
        
        bottomSheetController.present(popup, on: self)
    }
    
    func useDefaultSignature() {
        let docPath = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true).first
        let filePath = (docPath! as NSString).appendingPathComponent("sig.data")
        
        self.userHasDefaultSignatureExists = true
        self.setupToolbar()
        self.setupDefaultSignatureViews()
        
        self.signatureView.loadSignature(filePath)
    }
    
    func deleteDefaultSignature() {
        self.userHasDefaultSignatureExists = false
        
        self.setupToolbar()
        self.setupDefaultSignatureViews()
        self.signatureView.removeSignature()
    }
    
    @IBAction func onTouchSaveButton(_ sender: Any) {
        if let signature = signatureView.getSignatureAsImage() {
            if switchSaveSignature.isOn {
                let docPath = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true).first
                let filePath = (docPath! as NSString).appendingPathComponent("sig.data")
                signatureView.saveSignature(filePath)
            }
            signatureDelegate?.epSignature!(self, didSign: signature, boundingRect: signatureView.getSignatureBoundsInCanvas())
            dismiss(animated: true, completion: nil)
        } else {
            showAlert("You did not sign", andTitle: "Please draw your signature")
        }
    }
    
    @objc func onTouchCancelButton() {
        signatureDelegate?.epSignature!(self, didCancel: NSError(domain: "EPSignatureDomain", code: 1, userInfo: [NSLocalizedDescriptionKey:"User not signed"]))
        dismiss(animated: true, completion: nil)
    }
    
    @objc func onTouchUndoButton() {
        
    }
    
    @objc func onTouchRedoButton() {
        
    }
    
    @objc func onTouchEditButton() {
        
    }
    
    @objc func onTouchActionButton(_ barButton: UIBarButtonItem) {
        
    }
    
    @objc func onTouchClearButton() {
        signatureView.clear()
    }
    
    private func defaultSignatureExists() -> Bool {
        let docPath = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true).first
        let filePath = (docPath! as NSString).appendingPathComponent("sig.data")
        
        return FileManager.default.fileExists(atPath: filePath)
    }
    
    override open func didRotate(from fromInterfaceOrientation: UIInterfaceOrientation) {
        signatureView.reposition()
    }
}
