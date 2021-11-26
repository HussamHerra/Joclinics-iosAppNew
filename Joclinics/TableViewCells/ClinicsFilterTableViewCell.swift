import UIKit

protocol ClinicsFilterTableViewCellDelegate: AnyObject {
    func didTapButton(with title: String)
}
class ClinicsFilterTableViewCell: UITableViewCell {
    
    weak var delegate: ClinicsFilterTableViewCellDelegate?
    
    
    static let identifier = "cell"
    
    static func nib() -> UINib {
        return UINib(nibName: "ClinicsFilterTableViewCell", bundle: nil)
    }
    
    @IBOutlet var button: UIButton!
    var title = ""
    @IBAction func didTabButton(){
        delegate?.didTapButton(with: title)
    }
    
    func configure (with title: String){
        self.title = title
        button.setTitle(title, for: .normal)
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        button.setTitleColor(.link, for: .normal)
    }
    
    
}
