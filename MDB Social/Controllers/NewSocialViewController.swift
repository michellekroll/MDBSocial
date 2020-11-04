//
//  NewSocialViewController.swift
//  MDB Social
//
//  Created by Patrick Zhu on 11/3/20.
//

import UIKit
import FirebaseAuth
import Firebase


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
      
//        FirebaseRequest.shared.addEventInfo(eventPicture: imageUrl, eventName: firstname, date: date, desc: desc, completion: { [weak self] in
//                      guard let strongSelf = self else { return }
//                      strongSelf.performSegue(withIdentifier: "regisToMain", sender: nil)})
//
        }
}
extension NewSocialViewController: UINavigationControllerDelegate, UIImagePickerControllerDelegate {
    private func imagePickerController(_ picker: UIImagePickerController,
                                    didFinishPickingMediaWithInfo info: [String : Any]){
        uploadImageButton.removeFromSuperview()
        let chosenImage = info[UIImagePickerController.InfoKey.originalImage.rawValue] as! UIImage
        imageView.contentMode = .scaleAspectFit
        imageView.image = chosenImage // this is not actually helping to display the image
        print(imageView.image == nil)
        dismiss(animated:true, completion: nil)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
    }
}
