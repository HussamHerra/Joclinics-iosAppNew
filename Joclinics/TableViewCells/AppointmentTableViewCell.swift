import UIKit

class AppointmentTableViewCell: UITableViewCell {
    
    @IBOutlet weak var doctorImage: UIImageView!
    @IBOutlet weak var hour: UILabel!
    @IBOutlet weak var when: UILabel!
    @IBOutlet weak var clinicName: UILabel!
    @IBOutlet weak var docttorName: UILabel!
    @IBOutlet weak var type: UILabel!
    @IBOutlet weak var date: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    static let identifier = "cell"
    static func nib() -> UINib {
        return UINib(nibName: "AppointmentTableViewCell", bundle: nil)
    }
    func configure (with appointment: Appointment){
        self.clinicName.text = appointment.clinicName
        self.docttorName.text = appointment.doctorName
        self.type.text = appointment.specialization
        self.date.text = appointment.date
        self.hour.text = appointment.hour
        if appointment.doctorGender == "انثى" {
            self.doctorImage.image = UIImage(named: "WomenDoctor.svg")
        }
        else {
            self.doctorImage.image = UIImage(named: "Doctor.svg")
        }
        let currentDate = Date()
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        let someDateTime = dateFormatter.date(from: appointment.date)
        let sub = someDateTime!.timeIntervalSinceReferenceDate -  currentDate.timeIntervalSinceReferenceDate
        let whenTime = (String(Int(ceil((sub / 3600) / 24))))
        self.when.text = whenTime == "0" ? "اليوم" : "بعد \(whenTime) يوم"
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
    }
}
