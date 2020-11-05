//
//  DetailViewController.swift
//  MDB Social
//
//  Created by Patrick Zhu on 11/4/20.
//

import UIKit

class DetailViewController: UIViewController {

    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var eventLabel: UILabel!
    @IBOutlet weak var eventDesc: UILabel!
    @IBOutlet weak var buttonInterested: UIButton!
    @IBOutlet weak var numInterestedHeader: UILabel!
    var event: Event!
    var tapped: Bool = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        eventLabel.text = event.name
        eventDesc.text = event.desc
        imageView.load(urlString: event.imgURL)
        buttonInterested.setTitle(String(event.numInterested), for: .normal)
    }
    
    @IBAction func buttonTapped(_ sender: Any) {
        if !tapped {
            event.numInterested += 1
        } else {
            event.numInterested -= 1
        }
        self.viewDidLoad()
        
    }
    
}

extension UIImageView {
    func load(urlString: String) {
        guard let url = URL(string: urlString)else {
            return
        }
        DispatchQueue.global().async { [weak self] in
            if let data = try? Data(contentsOf: url) {
                if let image = UIImage(data: data) {
                    DispatchQueue.main.async {
                        self?.image = image
                    }
                }
            }
        }
    }
}
