//
//  NewsFeedTableViewCell.swift
//  Joclinics
//
//  Created by Hussam Abuherra on 27/11/2021.
//

import UIKit

class NewsFeedTableViewCell: UITableViewCell {

    @IBOutlet weak var post: UILabel!
    @IBOutlet weak var title: UILabel!
    @IBOutlet weak var doctorName: UILabel!
    static let identifier = "cell"
    
    static func nib() -> UINib {
        return UINib(nibName: "NewsFeedTableViewCell", bundle: nil)
    }
    
    func configure (with newsFeed: NewsFeedData){
        self.title.text = newsFeed.title
        self.post.text = newsFeed.description
        self.doctorName.text = newsFeed.docName
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
}
