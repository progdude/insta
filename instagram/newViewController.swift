//
//  newViewController.swift
//  instagram
//
//  Created by Archit Rathi on 2/22/16.
//  Copyright © 2016 Archit Rathi. All rights reserved.
//

import UIKit

class newViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
let vc = UIImagePickerController()
    @IBOutlet weak var capt: UITextField!
    @IBOutlet weak var imag: UIImageView!
    
    @IBAction func post(sender: AnyObject) {
        UserMedia.postUserImage(imag.image!, withCaption: capt.text, withCompletion: nil)
        self.performSegueWithIdentifier("back", sender: nil)
    }
    
    @IBAction func choose(sender: AnyObject) {
        
        vc.delegate = self
        vc.allowsEditing = true
        vc.sourceType = UIImagePickerControllerSourceType.PhotoLibrary
        
        self.presentViewController(vc, animated: true, completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func imagePickerController(picker: UIImagePickerController,
        didFinishPickingMediaWithInfo info: [String : AnyObject]) {
            let editedImage = info[UIImagePickerControllerEditedImage] as! UIImage
            
            vc.dismissViewControllerAnimated(true) { () -> Void in
                self.imag.image = editedImage
            }
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
