//
//  ViewController.swift
//  pickimages
//
//  Created by Dennis on 5/20/15.
//  Copyright (c) 2015 Dennis. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

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
        bottom.defaultTextAttributes = memeTextAttributes
        bottom.text = "BOTTOM"
        bottom.textAlignment = NSTextAlignment.Center
    }
    
    override func viewWillAppear(animated: Bool) {
        cameraButton.enabled = UIImagePickerController.isSourceTypeAvailable(UIImagePickerControllerSourceType.Camera)
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

