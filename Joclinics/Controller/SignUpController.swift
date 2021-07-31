//
//  xViewController.swift
//  Joclinics
//
//  Created by Hussam on 16/04/2021.
//

import UIKit

class SignUpController: UIViewController , UITextFieldDelegate{
    @IBOutlet weak var emailValidation: UILabel!
    @IBOutlet weak var userNameVlidation: UILabel!
    @IBOutlet weak var spinnerView: UIView!
    @IBOutlet weak var email: UITextField!
    @IBOutlet weak var userName: UITextField!
    @IBOutlet weak var dateOfBirth: UIDatePicker!
    @IBOutlet weak var firstName: UITextField!
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var gender: UITextField!
    @IBOutlet weak var lastName: UITextField!
    @IBOutlet weak var password: UITextField!
    @IBOutlet weak var chroD: UITextField!
    @IBOutlet weak var phoneNumber: UITextField!
    @IBOutlet weak var address: UITextField!
    var code : Int!
    var patentManager = PatentManager()
    override func viewDidLoad() {
        super.viewDidLoad()
        
        emailValidation.isHidden = true
        userNameVlidation.isHidden = true
        firstName.delegate = self
        lastName.delegate = self
        userName.delegate = self
        email.delegate = self
        patentManager.delegate = self
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
            NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
    }
    
    var isExpand : Bool = false
    @objc func keyboardWillShow(notification: NSNotification) {
        if !isExpand {
            self.scrollView.contentSize = CGSize(width : self.scrollView.frame.width,height: self.scrollView.frame.height + 300)
            isExpand = true
        }
    }

    @objc func keyboardWillHide(notification: NSNotification) {
        if isExpand {
            self.scrollView.contentSize = CGSize(width : self.scrollView.frame.width,height: self.scrollView.frame.height - 300)
            isExpand = false
        }
    }
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField == firstName {
            lastName.becomeFirstResponder()
            spinnerView.isHidden = false
        }
        else if textField == lastName{
            userName.becomeFirstResponder()
        }
        else if textField == userName{
            email.becomeFirstResponder()
        }
        return true
    }
    
    @IBAction func signUpBtn(_ sender: UIButton) {
        print(firstName.hasText)
       if (!firstName.hasText || !lastName.hasText || !userName.hasText || !password.hasText || !email.hasText || !gender.hasText || !address.hasText || !phoneNumber.hasText || !lastName.hasText || !lastName.hasText) {
           self.showToast(message: "الرجاء ادخال جميع البيانات")
           view.endEditing(true)
       }
       else{
        spinnerView.isHidden = false
            code = Int.random(in: 10000...99999)
            patentManager.CheckIfUserNameOrEmailIsInDatabase(Email: email.text!, UserName: userName.text!, code: code)
        }
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "yyyy-MM-dd"
        let birthDate = dateFormatter.string(from: dateOfBirth.date)
        if segue.identifier == "toCodePageSegu" {
            let codePage = segue.destination as! CodeViewController
            codePage.code = code
            codePage.firstName = firstName.text!
            codePage.lastName = lastName.text!
            codePage.userName = userName.text!
            codePage.password = password.text!
            codePage.chroD = chroD.text!
            codePage.email = email.text!
            codePage.gender = gender.text!
            codePage.phoneNumber = phoneNumber.text!
            codePage.dateOfBirth = birthDate
            codePage.address = address.text!
        }
    }
}
extension SignUpController : PatentManagerDelegate{
    func doneSendEmail(_ patentManager: PatentManager) {
    }
    func didFailWithError() {
        DispatchQueue.main.async {
            self.spinnerView.isHidden = true
            //self.performSegue(withIdentifier: "toCodePageSegu", sender: self)
            self.userNameVlidation.isHidden = false
            self.emailValidation.isHidden = false
        }
    }
    func theEmailAndUserNameValid(_ patentManager: PatentManager) {
        DispatchQueue.main.async {
            self.spinnerView.isHidden = true
            //self.dismiss(animated: true, completion: nil)
            self.performSegue(withIdentifier: "toCodePageSegu", sender: self)
            //self.dismiss(animated: true, completion: nil)
        }
    }
    func didUpdatePatent(_ patentManager: PatentManager, patent: Patent) {
    }
    func didAddedPatent(_ patentManager: PatentManager) {
    }
}
extension UIViewController {
func showToast(message : String) {
    let size = message.count + 170
    let toastLabel = UILabel(frame: CGRect(x: self.view.frame.size.width/2 - 95, y: self.view.frame.size.height-120, width: CGFloat(size), height: 40))
    toastLabel.backgroundColor = UIColor.black.withAlphaComponent(0.6)
    toastLabel.textColor = UIColor.white
    toastLabel.font = .systemFont(ofSize: 12.0)
    toastLabel.textAlignment = .center;
    toastLabel.text = message
    toastLabel.alpha = 1.0
    toastLabel.layer.cornerRadius = 20;
    toastLabel.clipsToBounds  =  true
    self.view.addSubview(toastLabel)
    UIView.animate(withDuration: 0.5, delay: 1, options: .curveEaseOut, animations: {
         toastLabel.alpha = 0.0
    }, completion: {(isCompleted) in
        toastLabel.removeFromSuperview()
    })
} 
}
