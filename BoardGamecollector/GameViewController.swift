//
//  GameViewController.swift
//  BoardGamecollector
//
//  Created by Dylan Grozdanich on 1/19/17.
//  Copyright © 2017 Dylan Grozdanich. All rights reserved.
//

import UIKit

class GameViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    @IBOutlet weak var gameImgView: UIImageView!
    
    @IBOutlet weak var titleTextField: UITextField!
    
    @IBOutlet weak var addUpdateButton: UIButton!
    
    @IBOutlet weak var deleteButton: UIButton!
    
    var imagePicker = UIImagePickerController()
    
    var game : Game? = nil
    
    

    override func viewDidLoad() {
        super.viewDidLoad()

        
        imagePicker.delegate = self
        
        if game != nil {
            gameImgView.image = UIImage(data: game!.image as! Data)
            titleTextField.text = game!.title
            addUpdateButton.setTitle("Update", for: .normal)
        } else {
            deleteButton.isHidden = true
        }
        
       
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
   
    
    @IBAction func photosTapped(_ sender: Any) {
        imagePicker.sourceType = .photoLibrary
        
        present(imagePicker, animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        let image = info[UIImagePickerControllerOriginalImage] as! UIImage
        gameImgView.image = image
        
        imagePicker.dismiss(animated: true, completion: nil)
    }

   
    @IBAction func cameraTapped(_ sender: Any) {
        imagePicker.sourceType = .camera
        
        present(imagePicker, animated: true, completion: nil)
        
    }
    
    @IBAction func addTapped(_ sender: Any) {
        if game != nil {
            
            game!.title = titleTextField.text
            game!.image = UIImagePNGRepresentation(gameImgView.image!) as NSData?
        } else {
            let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
            
            let game = Game(context: context)
            game.title = titleTextField.text
            game.image = UIImagePNGRepresentation(gameImgView.image!) as NSData?
            
        }
        
        (UIApplication.shared.delegate as! AppDelegate).saveContext()
        
        navigationController!.popViewController(animated: true)
    }
    @IBAction func deleteTapped(_ sender: Any) {
         let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        
        context.delete(game!)
        
        (UIApplication.shared.delegate as! AppDelegate).saveContext()
         navigationController!.popViewController(animated: true)
    }
    
}
