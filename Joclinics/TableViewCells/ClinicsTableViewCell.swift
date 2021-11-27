//
//  ClinicsTableViewCell.swift
//  Joclinics
//
//  Created by Hussam Abuherra on 27/11/2021.
//

import UIKit

protocol ClinicsTableViewCellDelegate: AnyObject {
    func didTapButton()
}
class ClinicsTableViewCell: UITableViewCell {
    
    weak var delegate : ClinicsTableViewCellDelegate?
    
    @IBOutlet weak var clinicName: UILabel!
    static let identifier = "cell"
    @IBOutlet weak var ratingStars: StarRatingView!
    @IBOutlet weak var clinicPhoneNumber: UILabel!
    @IBOutlet weak var clinicLocation: UILabel!
    @IBOutlet weak var clinicType: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    func didTapButton(){
        self.delegate?.didTapButton()
    }
    static func nib() -> UINib {
        return UINib(nibName: "ClinicsTableViewCell", bundle: nil)
    }
    func configure (with clinics: Clinics){
        self.clinicName.text = clinics.name
        self.clinicPhoneNumber.text = clinics.phoneNumber
        self.clinicLocation.text = clinics.location
        self.clinicType.text = clinics.classification
        self.ratingStars.rating = Float(clinics.rate)
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
//        super.setSelected(selected, animated: animated)
        didTapButton()
    }
}
