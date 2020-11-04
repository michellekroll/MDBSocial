//
//  NewSocialViewController.swift
//  MDB Social
//
//  Created by Patrick Zhu on 11/3/20.
//

import UIKit
import FirebaseAuth
import Firebase


class NewSocialViewController: UIViewController, UIImagePickerControllerDelegate & UINavigationControllerDelegate {

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
        eventImageViewSetUp()

        // Do any additional setup after loading the view.
    }
    @IBAction func uploadImageButtonTapped(_ sender: Any) {
    }
    
      
      
    
    
    
    
    func eventImageViewSetUp() {
        uploadImageButton.addTarget(self, action: #selector(addPhoto), for: .touchUpInside)
        
    }
    
    @objc func addPhoto(_ sneder: UIButton) {
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
        picker.allowsEditing = true
        present(picker, animated: true, completion: nil)
    }
    
    func pickImage() {
        picker.sourceType = .photoLibrary
        picker.allowsEditing = false
        present(picker, animated: true, completion: nil)
    }
    
    
//      @IBAction func saveEventTapped(_ sender: Any) {
//          let name = nameTextField.text
//          let date = datePicker.date
//          let desc = descTextField.text
//        guard let image = imageView.image ,let data = image.jpegData(compressionQuality: 1.0) else {
//            presentAlert(title: "Error", message: "Something went wrong")
//            return
//        }
//
//        let imageName = UUID().uuidString
//        let imageReference = Storage.storage().reference().child(MyKeys.imagesFolder).child(imageName)
        
        
          
//        FirebaseRequest.shared.addEventInfo(eventPicture: imageUrl, eventName: firstname, date: date, desc: desc, completion: { [weak self] in
//                      guard let strongSelf = self else { return }
//                      strongSelf.performSegue(withIdentifier: "regisToMain", sender: nil)})
//
//        }
    
    
//    func showImagePickerControllerActionSheet() {
//        let photoLibraryAction = UIAlertAction(title: "Choose from library", style:. default) { (action) in
//            self.showImagePickerController(sourceType: .photoLibrary)
//        }
//        let cameraAction = UIAlertAction(title: "Take a new photo", style:. default) { (action) in
//            self.showImagePickerController(sourceType: .camera)
//        }
//        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
//
//        NewSocialViewController.AlertService.showAlert(style: .actionSheet, title: "Choose your image", message: nil, actions: [photoLibraryAction, cameraAction, cancelAction], completion: nil)
//    }
//
//    func showImagePickerController(sourceType: UIImagePickerController.SourceType) {
//        let imagePickerController = UIImagePickerController()
//        imagePickerController.delegate = self
//        imagePickerController.allowsEditing = true
//        imagePickerController.sourceType = .photoLibrary
//
//        present(imagePickerController, animated: true, completion: nil)
//    }
//
//    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
//        if let editedImage = info[UIImagePickerController.InfoKey.editedImage] as? UIImage {
//            EventPicture.image = editedImage
//        } else if let originalImage = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
//            EventPicture.image = originalImage
//        }
//        dismiss(animated: true, completion: nil)
//
//    }
//
//
//
//    class AlertService {
//
//        static func showAlert(style: UIAlertController.Style, title: String?, message: String?, actions: [UIAlertAction] = [UIAlertAction(title: "Ok", style: .cancel, handler: nil)], completion: (() -> Swift.Void)? = nil) {
//            let alert = UIAlertController(title: title, message: message, preferredStyle: style)
//            for action in actions {
//                alert.addAction(action)
//            }
//            if let topVC = UIApplication.getTopMostViewController() {
//                alert.popoverPresentationController?.sourceView = topVC.view
//                alert.popoverPresentationController?.sourceRect = CGRect(x: topVC.view.bounds.midX, y: topVC.view.bounds.midY, width: 0, height: 0)
//                alert.popoverPresentationController?.permittedArrowDirections = []
//                topVC.present(alert, animated: true, completion: completion)
//            }
//        }
//
//    }
//}
//
//extension UIApplication {
//    class func getTopMostViewController(base: UIViewController? = UIApplication.shared.keyWindow?.rootViewController) -> UIViewController? {
//        if let nav = base as? UINavigationController {
//            return getTopMostViewController(base: nav.visibleViewController)
//        }
//        if let tab = base as? UITabBarController {
//            if let selected = tab.selectedViewController {
//                return getTopMostViewController(base: selected)
//            }
//        }
//        if let presented = base?.presentedViewController {
//            return getTopMostViewController(base: presented)
//        }
//        return base
//    }
//}
}
