//
//  FeedCell.swift
//  MDB Social
//
//  Created by Michelle Kroll on 11/4/20.
//

import UIKit

class FeedCell: UITableViewCell {

    @IBOutlet weak var eventImageView: UIImageView!
    @IBOutlet weak var eventTitle: UILabel!
    @IBOutlet weak var eventNumInterested: UILabel!
    @IBOutlet weak var eventCreator: UILabel!
    @IBOutlet weak var eventInterested: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
