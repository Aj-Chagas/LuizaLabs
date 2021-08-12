//
//  TweetTimelineTableViewCell.swift
//  UI
//
//  Created by Anderson Chagas on 11/08/21.
//

import UIKit
import Presentation

class TweetTimelineTableViewCell: UITableViewCell {

    @IBOutlet weak var tweetLabel: UILabel!
    @IBOutlet weak var arrowRight: UIImageView!
    
    static let kIdentifier = "TweetTimelineTableViewCell"
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func setup(_ model: TweetViewModel) {
        tweetLabel.text = model.text
    }

}
