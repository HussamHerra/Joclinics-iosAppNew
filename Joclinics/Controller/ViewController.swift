

import UIKit

class ViewController: UIViewController, UITextFieldDelegate{

    @IBOutlet weak var userName: UITextField!
    @IBOutlet weak var spinnerView: UIView!
    @IBOutlet weak var loginType: UIButton!
    @IBOutlet weak var password: UITextField!
    var patentManager = PatentManager()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        userName.delegate = self;
        password.delegate = self;
        patentManager.delegate = self
    }
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
    }
    @IBAction func changeType(_ sender: UIButton) {
        if sender.currentTitle == "مريض" {
            loginType.setTitle("طبيب", for: .normal)
        }
        else {
            loginType.setTitle("مريض", for: .normal)
        }
    }
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField == userName {
            password.becomeFirstResponder()
        }
        else {
            view.endEditing(true);
        }
        return true
    }
    @IBAction func loginBtn(_ sender: UIButton) {
        if (!userName.hasText || !password.hasText) {
            self.showToast(message: "يجب ادخال كلمة السر و البريد الالكتروني")
        }
        else{
        if loginType.currentTitle == "مريض"  {
            spinnerView.isHidden = false
            patentManager.LoginPatent(password: password.text!, userName: userName.text!)
        }
        }
    }
}
extension ViewController : PatentManagerDelegate{
    func doneSendEmail(_ patentManager: PatentManager) {
    }
    func didFailWithError() {
        DispatchQueue.main.async {
            self.spinnerView.isHidden = true
            print("wrong username or password")
        }
    }
    
    func theEmailAndUserNameValid(_ patentManager: PatentManager) {
        
    }
    
    func didAddedPatent(_ patentManager: PatentManager) {
        
    }
    func didUpdatePatent(_ patentManager: PatentManager, patent: Patent) {                
        do{
            //this section to convert patent object to json and to string and store it in Iphone storege
            let preferences = UserDefaults.standard
            let encodedData = try JSONEncoder().encode(patent)
            let jsonString = String(data: encodedData,encoding: .utf8)
            preferences.setValue(jsonString, forKey: "Patent")
            preferences.synchronize()
        }
        catch{
            print("error")
        }
        DispatchQueue.main.async {
            self.spinnerView.isHidden = true
            self.performSegue(withIdentifier: "patentIDsAGUE", sender: Self.self)
        }
    }
}
