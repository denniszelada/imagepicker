//
//  ViewController.swift
//  pickimages
//
//  Created by Dennis on 5/20/15.
//  Copyright (c) 2015 Dennis. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate, UITextFieldDelegate {

    @IBOutlet weak var imagePickerViewer: UIImageView!
    
    @IBOutlet weak var cameraButton: UIBarButtonItem!
    
    @IBOutlet weak var top: UITextField!
    
    @IBOutlet weak var bottom: UITextField!
    
    let memeTextAttributes = [
        NSStrokeColorAttributeName: UIColor.blackColor(), //Black outline
        NSForegroundColorAttributeName: UIColor.whiteColor(),
        NSFontAttributeName: UIFont(name: "HelveticaNeue-CondensedBlack", size: 40)!,
        NSStrokeWidthAttributeName: -3 //outline width
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        top.defaultTextAttributes = memeTextAttributes
        top.text = "TOP"
        top.textAlignment = NSTextAlignment.Center
        top.delegate = self
        bottom.defaultTextAttributes = memeTextAttributes
        bottom.text = "BOTTOM"
        bottom.textAlignment = NSTextAlignment.Center
        bottom.delegate = self
    }
    
    func textFieldDidBeginEditing(textField: UITextField) {
        
        if textField.text == "TOP" || textField.text == "BOTTOM" {
            textField.text = ""
        }
        if textField.isEqual(bottom) {
            self.subscribeToKeyboardNotifications()
        }
    }
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        if textField.isEqual(bottom) {
            self.unsubscribeFromKeyboardNotifications()
        }
        
        return true
    }

    func subscribeToKeyboardNotifications() {
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "keyboardWillShow:", name: UIKeyboardWillShowNotification, object: nil)
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "keyboardWillHide:", name: UIKeyboardWillHideNotification, object: nil)
    }
    
    func unsubscribeFromKeyboardNotifications() {
        NSNotificationCenter.defaultCenter().removeObserver(self, name:
            UIKeyboardWillShowNotification, object: nil)
        NSNotificationCenter.defaultCenter().removeObserver(self, name: UIKeyboardWillHideNotification, object: nil)
    }
    
    func keyboardWillShow(notification: NSNotification) {
        self.view.frame.origin.y -= getKeyboardHeight(notification)
    }
    
    func keyboardWillHide(notification: NSNotification) {
        self.view.frame.origin.y += getKeyboardHeight(notification)
    }
    
    func getKeyboardHeight(notification: NSNotification) -> CGFloat {
        let userInfo = notification.userInfo
        let keyboardSize = userInfo![UIKeyboardFrameEndUserInfoKey] as! NSValue // of CGRect
        return keyboardSize.CGRectValue().height
    }
    
    @IBAction func pickAnImage(sender: AnyObject) {
        let imagePicker = UIImagePickerController()
        imagePicker.delegate = self
        imagePicker.sourceType = UIImagePickerControllerSourceType.PhotoLibrary
        self.presentViewController(imagePicker, animated: true, completion: nil)
    }

    @IBAction func takeAPhoto(sender: AnyObject) {
        let imagePicker = UIImagePickerController()
        imagePicker.delegate = self
        imagePicker.sourceType = UIImagePickerControllerSourceType.Camera
        self.presentViewController(imagePicker, animated: true, completion: nil)
        
    }
   
    func imagePickerController(picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [NSObject : AnyObject]) {
        if let image = info[UIImagePickerControllerOriginalImage] as? UIImage {
            imagePickerViewer.image = image
            self.dismissViewControllerAnimated(true, completion: nil)
        }
    }
}

