import UIKit

class PatentClinicsController: UIViewController {
    
    @IBOutlet weak var pleaseWait: UIView!
    @IBOutlet weak var filterContainer: UIView!
    @IBOutlet weak var sortClinics: UIView!
    @IBOutlet weak var cityFilterContainer: UIView!
    var patentFilter = PatentFilterController();
    var filterType = FilterStruct();
    var clinicsManager = ClinicsManager()
    override func viewDidLoad() {
        super.viewDidLoad()
        pleaseWait.isHidden = false
        clinicsManager.delegate = self
        clinicsManager.getClinics()
    }
    @IBAction func filterClinics(_ sender: UIButton) {
        filterContainer.isHidden = false
        switch sender.tag {
        case 1:
            RestAllContainer ()
            filterContainer.isHidden = false
        case 2:
            RestAllContainer ()
            sortClinics.isHidden = false
        case 3:
            RestAllContainer ()
            cityFilterContainer.isHidden = false
        default:
            RestAllContainer ()
            print("nothing")
        }
    }
    func RestAllContainer (){
        filterContainer.isHidden = true
        sortClinics.isHidden = true
        cityFilterContainer.isHidden = true
    }
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        RestAllContainer ()
    }
}
extension PatentClinicsController : ClinicsManagerDelegate{
    func didGetClinics(clinics: [Clinics]) {
        DispatchQueue.main.async {
            print("clinics from controller" , clinics)
            self.pleaseWait.isHidden = true
        }
    }
    func didFailWithError() {
        DispatchQueue.main.async {
            self.pleaseWait.isHidden = true
        }
    }
}
