//
//  ChangePasswordController.swift
//  Joclinics
//
//  Created by Hussam on 25/06/2021.
//

import UIKit

class ChangePasswordController: UIViewController {
    @IBOutlet weak var reEnterNewPassword: UITextField!
    @IBOutlet weak var newPassword: UITextField!
    @IBOutlet weak var pleaseWait: UIView!
    @IBOutlet weak var ChangePasswordSpinner: UIView!
    var Email : String!
    var patentManager = PatentManager()
    override func viewDidLoad() {
        patentManager.delegate = self
        super.viewDidLoad()
    }
    @IBAction func changePassword(_ sender: Any) {
        if newPassword.text! != reEnterNewPassword.text! {
            self.showToast(message: "كلمة المرور غير متطابقة")
        }
        else {
            pleaseWait.isHidden = false
            patentManager.ChangePassword(NewPassword: newPassword.text!, Email: Email)
        }
    }
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
    }
}
extension ChangePasswordController : PatentManagerDelegate{
    func didUpdatePatent(_ patentManager: PatentManager, patent: Patent) {
    }
    func didAddedPatent(_ patentManager: PatentManager) {
    }
    func didFailWithError() {
        print("an error occured")
    }
    func theEmailAndUserNameValid(_ patentManager: PatentManager) {
    }
    func doneSendEmail(_ patentManager: PatentManager) {
        DispatchQueue.main.async {
            //self.dismiss(animated: true, completion: nil)
            self.performSegue(withIdentifier: "backToLoginScreen", sender: self)
        }
    }
}
