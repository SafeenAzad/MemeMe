//
//  MemeEditorViewController.swift
//  MemeMe
//
//  Created by Safeen Azad on 8/9/17.
//  Copyright © 2017 SafeenAzad. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UIImagePickerControllerDelegate , UINavigationControllerDelegate, UITextFieldDelegate{
        
    @IBOutlet weak var textField1: UITextField!
    @IBOutlet weak var textField2: UITextField!
        
        @IBOutlet weak var imagePickerView: UIImageView!
        @IBOutlet weak var cameraButton: UIBarButtonItem!
    
    let memeTextAttributes:[String:Any] = [
        NSStrokeColorAttributeName: UIColor.black,
        
        NSForegroundColorAttributeName: UIColor.white,
        
        NSFontAttributeName: UIFont(name: "HelveticaNeue-CondensedBlack", size: 40)!,
        
        NSStrokeWidthAttributeName: -0.3]
    
    
    
        override func viewDidLoad() {
            super.viewDidLoad()
            // Do any additional setup after loading the view, typically from a nib.
            
            
            textField1.defaultTextAttributes = memeTextAttributes
            textField2.defaultTextAttributes = memeTextAttributes
            textField1.delegate = self
            textField2.delegate = self
            
        }
    
    
    
    
        @IBAction func pickAnImageFromAlbum(_ sender: Any) {
            
            let imagePicker = UIImagePickerController()
            imagePicker.delegate = self
            imagePicker.sourceType = .photoLibrary
            present(imagePicker, animated: true, completion: nil)
            
            
        }
        @IBAction func pickAnImageFromCamera(_ sender: Any) {
            
            let imagePicker = UIImagePickerController()
            imagePicker.delegate = self
            imagePicker.sourceType = .camera
            present(imagePicker, animated: true, completion: nil)
            
            
        }
        
        func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
            
            let image = info[UIImagePickerControllerOriginalImage] as! UIImage
            imagePickerView.image = image
            
            
            self.dismiss(animated: true, completion: nil)
        }
  
        func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
            picker.dismiss(animated: true, completion: nil)
    }
    
    
    
    
    
    
    
    
    func subscribeToKeyboardNotifications() {
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(_:)), name: .UIKeyboardWillShow, object: nil)
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillDissapear(_:)), name: .UIKeyboardWillHide, object: nil)
    }
    
    func unsubscribeFromKeyboardNotifications() {
        
        NotificationCenter.default.removeObserver(self, name: .UIKeyboardWillShow, object: nil)
    }
    
    
    
    
    func keyboardWillShow(_ notification:Notification) {
        
        view.frame.origin.y = 0 - getKeyboardHeight(notification)
    }
    func keyboardWillDissapear(_ notification:Notification) {
        
        view.frame.origin.y = 0 
    }

    
    func getKeyboardHeight(_ notification:Notification) -> CGFloat {
        
        let userInfo = notification.userInfo
        let keyboardSize = userInfo![UIKeyboardFrameEndUserInfoKey] as! NSValue // of CGRect
        return keyboardSize.cgRectValue.height
    }
    
    
    
    
    
        override func viewWillAppear(_ animated: Bool) {
            
            super.viewWillAppear(animated)
            cameraButton.isEnabled = UIImagePickerController.isSourceTypeAvailable(.camera)
            subscribeToKeyboardNotifications()
        }
    
        override func viewWillDisappear(_ animated: Bool) {
            
            super.viewWillDisappear(animated)
            unsubscribeFromKeyboardNotifications()
        }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        textField.text = ""
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        
        return true;
    }
    
}
