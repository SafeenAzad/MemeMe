//
//  MemeEditorViewController.swift
//  MemeMe
//
//  Created by Safeen Azad on 8/9/17.
//  Copyright © 2017 SafeenAzad. All rights reserved.
//

import UIKit
class ViewController: UIViewController, UIImagePickerControllerDelegate , UINavigationControllerDelegate, UITextFieldDelegate{
    
    
    @IBOutlet weak var navBar: UINavigationBar!
    @IBOutlet weak var textField1: UITextField!
    @IBOutlet weak var textField2: UITextField!
    @IBOutlet weak var toolBar: UIToolbar!
    
    @IBOutlet weak var imagePickerView: UIImageView!
    @IBOutlet weak var cameraButton: UIBarButtonItem!
    
    var isBottom = false
    
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
        
        
        textField1.textAlignment = NSTextAlignment.center
        textField2.textAlignment = NSTextAlignment.center
        
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
        NotificationCenter.default.removeObserver(self, name: .UIKeyboardWillHide, object: nil)
    }
    
    
    
    
    func keyboardWillShow(_ notification:Notification){
        if isBottom {
            view.frame.origin.y = 0 - getKeyboardHeight(notification)
            
        }
    }
    func keyboardWillDissapear(_ notification:Notification) {
        if isBottom {
            view.frame.origin.y = 0
        }
    }
    
    
    func getKeyboardHeight(_ notification:Notification) -> CGFloat {
        
        let userInfo = notification.userInfo
        let keyboardSize = userInfo![UIKeyboardFrameEndUserInfoKey] as! NSValue // of CGRect
        return keyboardSize.cgRectValue.height
    }
    
    
    func generateMemedImage() -> UIImage {
        
        
        self.navBar.isHidden = true
        self.toolBar.isHidden = true
        
        
        // Render view to an image
        UIGraphicsBeginImageContext(self.view.frame.size)
        view.drawHierarchy(in: self.view.frame, afterScreenUpdates: true)
        let memedImage:UIImage = UIGraphicsGetImageFromCurrentImageContext()!
        UIGraphicsEndImageContext()
        
        
        self.navBar.isHidden = false
        self.toolBar.isHidden = false
        
        return memedImage
    }
    
    
    func save() {
        let memedImage = generateMemedImage()
        let meme = Meme(textField1: textField1.text!, textField2: textField2.text!, image: imagePickerView.image, memedImage: memedImage)
        
        let object = UIApplication.shared.delegate
        let appDelegate = object as! AppDelegate
        appDelegate.memes.append(meme)
        
    }
    
    @IBAction func shareButton(_ sender: Any) {
        
        let share = generateMemedImage()
        let controller = UIActivityViewController(activityItems: [share], applicationActivities: nil)
        
        controller.popoverPresentationController?.barButtonItem = sender as? UIBarButtonItem
        controller.completionWithItemsHandler = {(viewType, completed, any, error) in
            if completed {
                self.save()
                self.dismiss(animated: true, completion: nil)
            }
        }
        self.present(controller, animated: true, completion: nil)
    }
    
    @IBAction func cancelButton(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
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
        if textField.text == "TOP" || textField.text == "BOTTOM" {
            textField.text = ""
        }
        
        if textField.tag == 0 {
            isBottom = false
        } else {
            isBottom = true
        }
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        textField.resignFirstResponder()
        return true;
    }
    
}
