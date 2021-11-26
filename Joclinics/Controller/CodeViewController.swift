import UIKit

class CodeViewController: UIViewController, PatentManagerDelegate {
    @IBOutlet weak var enterdCode: UITextField!
    @IBOutlet weak var theCode: UILabel!
    @IBOutlet weak var pleaseWait: UIView!
    var code : Int!
    var firstName : String!
    var lastName : String!
    var userName : String!
    var password : String!
    var chroD : String!
    var email : String!
    var gender : String!
    var phoneNumber : String!
    var dateOfBirth : String!
    var address : String!
    var patentManager = PatentManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("from code view controller")
        theCode.text = String(code)
        patentManager.delegate = self
    }
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
    }
    @IBAction func checkTheCode(_ sender: Any) {
        pleaseWait.isHidden = false
        if enterdCode.text! == String(code) {
            patentManager.SignUpPatent(FirstName: firstName, LastName: lastName, UserName: userName, Password: password, ChronicDiseases: chroD, Email: email, Gender: gender, PhoneNumber: phoneNumber, DateOfBirth: dateOfBirth, address: address)
            
        }
        else{
            pleaseWait.isHidden = true
        }
    }
    func didUpdatePatent(_ patentManager: PatentManager, patent: Patent) {
    }
    func didAddedPatent(_ patentManager: PatentManager) {
        DispatchQueue.main.async {
            self.pleaseWait.isHidden = true
            self.performSegue(withIdentifier: "backToLogin", sender: self)
        }
    }
    func didFailWithError() {
        print("an error occured")
    }
    func theEmailAndUserNameValid(_ patentManager: PatentManager) {
    }
    func doneSendEmail(_ patentManager: PatentManager) {
    }
}
