import UIKit

class NewsFeedTableViewCell: UITableViewCell {

    @IBOutlet weak var view: UIView!
    @IBOutlet weak var doctorImage: UIImageView!
//    @IBOutlet weak var post: UILabel!
    @IBOutlet weak var title: UILabel!
    @IBOutlet weak var postView: UITextView!
    @IBOutlet weak var doctorName: UILabel!
    static let identifier = "cell"
    
    static func nib() -> UINib {
        return UINib(nibName: "NewsFeedTableViewCell", bundle: nil)
    }
    
    func configure (with newsFeed: NewsFeedData){
        self.title.text = newsFeed.title
        self.postView.text = newsFeed.description
        self.doctorName.text = newsFeed.docName
        if newsFeed.docGender == "انثى" {
            self.doctorImage.image = UIImage(named: "WomenDoctor.svg")
        }        
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        view.frame.size.height = 500
    }
    
}
