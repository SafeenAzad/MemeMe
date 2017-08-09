//
//  MemeEditorViewController.swift
//  MemeMe
//
//  Created by Safeen Azad on 8/9/17.
//  Copyright © 2017 SafeenAzad. All rights reserved.
//

import UIKit

class MemeEditorViewController: UIViewController, UIImagePickerControllerDelegate , UINavigationControllerDelegate{
        
        
        @IBOutlet weak var imagePickerView: UIImageView!
        
        
        override func viewDidLoad() {
            super.viewDidLoad()
            // Do any additional setup after loading the view, typically from a nib.
        }
        @IBOutlet weak var cameraButton: UIBarButtonItem!
        
        @IBAction func pickAnImageFromAlbum(_ sender: Any) {
            
            let imagePicker = UIImagePickerController()
            imagePicker.delegate = self
            imagePicker.sourceType = .photoLibrary
            present(imagePicker, animated: true, completion: nil)
            
            
        }
        @IBAction func pickAnImageFromCamera(_ sender: Any) {
            
            let imagePicker = UIImagePickerController()
            imagePicker.delegate = self
            imagePicker.sourceType = .photoLibrary
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
        override func viewWillAppear(_ animated: Bool) {
            cameraButton.isEnabled = UIImagePickerController.isSourceTypeAvailable(.camera)
        }
        
        
}
