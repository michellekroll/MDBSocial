//
//  NewSocialViewController.swift
//  MDB Social
//
//  Created by Patrick Zhu on 11/3/20.
//

import UIKit
import FirebaseAuth
import Firebase
import FirebaseStorage
import FirebaseFirestoreSwift

class NewSocialViewController: UIViewController {
    
    @IBOutlet weak var EventPicture: UIImageView!
    @IBOutlet weak var uploadImageButton: UIButton!
    @IBOutlet weak var headerText: UILabel!
    @IBOutlet weak var nameHeader: UILabel!
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var dateHeader: UILabel!
    @IBOutlet weak var datePicker: UIDatePicker!
    @IBOutlet weak var descHeader: UILabel!
    @IBOutlet weak var descTextField: UITextField!
    @IBOutlet weak var imageView: UIImageView!
    let picker = UIImagePickerController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        view.addGestureRecognizer(tap)
        setup()
    }
    
    private func setup() {
        headerText.text = "Let's create your event."
        nameHeader.text = "Event name:"
        dateHeader.text = "Date picker:"
        descHeader.text = "Description:"
        uploadImageButton.addTarget(self, action: #selector(addPhoto), for: .touchUpInside)
        
    }
    
    @objc func addPhoto(_ sender: UIButton) {
        let alert = UIAlertController(title: "Choose an image", message: nil, preferredStyle: .actionSheet)
        alert.addAction(UIAlertAction(title: "Take Photo", style: .default, handler: { _ in
            self.openCamera()
        }))
        
        alert.addAction(UIAlertAction(title: "Choose from Library", style: .default, handler: { _ in
            self.pickImage()
        }))
        
        alert.addAction(UIAlertAction.init(title: "Cancel", style: .cancel, handler: nil))
        present(alert, animated: true, completion: nil)
        
    }
    
    func openCamera() {
        picker.sourceType = .camera
        picker.delegate = self
        picker.allowsEditing = true
        present(picker, animated: true, completion: nil)
    }
    
    func pickImage() {
        picker.sourceType = .photoLibrary
        picker.delegate = self
        picker.allowsEditing = true
        present(picker, animated: true, completion: nil)
    }
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
    
    
    @IBAction func saveEventTapped(_ sender: Any) {
        // Data in memory
        let data = self.imageView.image!.pngData()!
      
        print("entered")
        let document = Firestore.firestore().collection("eventInfo").document()
        let storageRef = Storage.storage().reference().child(document.documentID)
        // Create a reference to the file you want to upload
        // Upload the file to the path "images/rivers.jpg"
        let uploadTask = storageRef.putData(data, metadata: nil) { (metadata, error) in
            if error != nil {
                print(error!)
                return
            }
            storageRef.downloadURL { (url, error) in
                let event = Event.init(name: self.nameTextField.text!, date: self.datePicker.date, creator: "Patrick" , numInterested: 1, imgURL: url!.absoluteString)
                do {
                    try document.setData(from: event)
                } catch {
                    print(error)
                }
                
                
                self.dismiss(animated: true, completion: nil)
            }
   
    }
    }

}
extension NewSocialViewController: UINavigationControllerDelegate, UIImagePickerControllerDelegate {
    internal func imagePickerController(_ picker: UIImagePickerController,
                                        didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        uploadImageButton.removeFromSuperview()
        if let chosenImage = info[UIImagePickerController.InfoKey(rawValue: "UIImagePickerControllerEditedImage")] as? UIImage {
            imageView.image = chosenImage
        }
        imageView.contentMode = .scaleAspectFit
        picker.dismiss(animated:true, completion: nil)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true, completion: nil)
    }
}
