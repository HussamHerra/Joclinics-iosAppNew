
import UIKit
import SwiftUI
class PatentProfileController: UIViewController {
    @IBOutlet weak var testing: NSLayoutConstraint!
    var patent : Patent!
    
    @IBOutlet weak var Edit: UIButton!
    @IBOutlet weak var dateOfBirth: UIButton!
    @IBOutlet weak var location: UIButton!
    @IBOutlet weak var phoneNumber: UIButton!
    @IBOutlet weak var Email: UIButton!
    @IBOutlet weak var scrollView: UIView!
    @IBOutlet weak var accountDetailsS: UIStackView!
    let preferences = UserDefaults.standard
    override func viewDidLoad() {
        super.viewDidLoad()
        let jsonString = preferences.string(forKey: "Patent")
        if let dataFromJsonString = jsonString?.data(using: .utf8) {
            do{
                patent = try JSONDecoder().decode(Patent.self,from: dataFromJsonString)
            }
            catch{
                print("error testing")
            }
        }
        Edit.setTitle("تعديل", for: .normal)
        dateOfBirth.setTitle(patent!.DateOfBirth, for: .normal)
        location.setTitle(patent!.address, for: .normal)
        phoneNumber.setTitle(patent!.PhoneNumber, for: .normal)
        Email.setTitle(patent!.Email, for: .normal)
    }
    @IBAction func accountDetails(_ sender: Any) {
        
        accountDetailsS.isHidden = !accountDetailsS.isHidden
        
        testing.constant = accountDetailsS.isHidden ? 200 : 420
    }
    @IBAction func logOut(_ sender: Any) {
        preferences.removeObject(forKey: "Patent")
        preferences.synchronize()
        self.dismiss(animated: true, completion: nil)
        self.performSegue(withIdentifier: "test", sender: self.self)
    }
}

