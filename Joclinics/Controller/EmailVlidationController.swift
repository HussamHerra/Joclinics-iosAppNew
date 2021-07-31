//
//  EmailVlidationController.swift
//  Joclinics
//
//  Created by Hussam on 21/06/2021.
//

import UIKit

class EmailVlidationController: UIViewController {

    @IBOutlet weak var email: UITextField!
    @IBOutlet weak var pleaseWait: UIView!
    var code : Int!
    @IBOutlet weak var codeView: UIView!
    @IBOutlet weak var emailView: UIView!
    @IBOutlet weak var validationCode: UITextField!
    var patentManager = PatentManager()
    override func viewDidLoad() {
        patentManager.delegate = self
        super.viewDidLoad()
    }
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
    }
    @IBAction func sendCode(_ sender: Any) {
        pleaseWait.isHidden = false
        code = Int.random(in: 10000...99999)
        if email.hasText {
            view.endEditing(true)
            patentManager.SendCodeToEmail(Email: email.text!, Code: code)
        }
        else{
            pleaseWait.isHidden = true
            self.showToast(message: "يجب ادخال البريد الالكتروني")
        }
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toChangePassPage" {
            let ChangePassPage = segue.destination as! ChangePasswordController
            ChangePassPage.Email = email.text!
        }
    }
    @IBAction func isVaidCode(_ sender: Any) {
        if validationCode.hasText {
            if validationCode.text! == String(code){
                self.performSegue(withIdentifier: "toChangePassPage", sender: self)
            }
        }
        else{
            validationCode.text = String(code)
            self.showToast(message: "يجب ادخال الرمز")
       }
    }
}
extension EmailVlidationController : PatentManagerDelegate {
    func didUpdatePatent(_ patentManager: PatentManager, patent: Patent) {
    }
    func didAddedPatent(_ patentManager: PatentManager) {
    }
    func didFailWithError() {
        DispatchQueue.main.async{
            self.pleaseWait.isHidden = true
            print("an error occured")
        }
    }
    func theEmailAndUserNameValid(_ patentManager: PatentManager) {
    }
    func doneSendEmail(_ patentManager: PatentManager) {
        DispatchQueue.main.async{
            self.pleaseWait.isHidden = true
            self.emailView.isHidden = true
            self.codeView.isHidden = false
            self.showToast(message: "تم ارسال الرمز الى البريد الالكتروني")
            print("the code is : " , self.code!)
            print("done send email")
        }
    }
}
