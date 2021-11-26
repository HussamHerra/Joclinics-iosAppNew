//
//import UIKit
//import SwiftUI
//class PatentProfileController: UIViewController {
//    var patent : Patent!
//    let myButton = UIButton()
//    let myImage = UIImage(named: "AppIcon")
//    var list = ["1", "2", "3"]
//    let preferences = UserDefaults.standard
//    @IBOutlet weak var textBox: UITextField!
//    @IBOutlet weak var dropDown: UIPickerView!
//    override func viewDidLoad() {
//        super.viewDidLoad()
////        createView()
////        let jsonString = preferences.string(forKey: "Patent")
////        if let dataFromJsonString = jsonString?.data(using: .utf8) {
////            do{
////                patent = try JSONDecoder().decode(Patent.self,from: dataFromJsonString)
////                userName.text = patent!.UserName
////                firstLastName.text = "\(patent!.FirstName) \(patent!.LastName)"
////                //print(patent!)
////            }
////            catch{
////                print("error testing")
////            }
////        }
//    }
//
//
//
//        public func numberOfComponents(in pickerView: UIPickerView) -> Int{
//            return 1
//        }
//
//        public func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int{
//
//            return list.count
//        }
//
//        func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
//
//            self.view.endEditing(true)
//            return list[row]
//        }
//
//        func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
//
//            self.textBox.text = self.list[row]
//            self.dropDown.isHidden = true
//        }
//
//        func textFieldDidBeginEditing(_ textField: UITextField) {
//
//            if textField == self.textBox {
//                self.dropDown.isHidden = false
//                //if you don't want the users to se the keyboard type:
//
//                textField.endEditing(true)
//            }
//        }
//
//
//
//    @objc func buttonAction(sender: UIButton!) {
//              print("Button Clicked")
//         }
//    // we use it when we need to create wedgit coding
//    func createView(){
//        myButton.setTitle("test", for: .normal)
//        myButton.backgroundColor = .red
//        myButton.setTitleColor(.white, for: .normal)
//        myButton.layer.cornerRadius = 10
//        view.addSubview(myButton)
//        myButton.addTarget(self, action: #selector(buttonAction), for: .touchUpInside)
//        myButton.translatesAutoresizingMaskIntoConstraints = false
//        let imageView = UIImageView(image: myImage!)
//        NSLayoutConstraint.activate([
//            myButton.leadingAnchor.constraint(equalTo: view.leadingAnchor),
//            myButton.centerYAnchor.constraint(equalTo: view.centerYAnchor),
//            myButton.widthAnchor.constraint(equalToConstant: 250),
//            myButton.heightAnchor.constraint(equalToConstant: 50),
//
////            imageView.widthAnchor.constraint(equalToConstant: 180),
////            imageView.heightAnchor.constraint(equalToConstant: 180),
//
////            imageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
////            imageView.topAnchor.constraint(equalTo: view.topAnchor),
////            imageView.widthAnchor.constraint(equalToConstant: 250),
////            imageView.heightAnchor.constraint(equalToConstant: 50),
//        ])
//
////        [imageView setCenter:superCenter];
//
//        imageView.frame = CGRect(x: 0, y: 0, width: 150, height: 250)
//
////        imageView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
////        imageView.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: 28).isActive = true
//
//
////        view.addSubview(imageView)
////        image.
//
////        view.backgroundColor = .blue
//
//    }
//    @IBAction func logOut(_ sender: UIButton) {
//        preferences.removeObject(forKey: "Patent")
//        preferences.synchronize()
//        self.dismiss(animated: true, completion: nil)
//        self.performSegue(withIdentifier: "test", sender: self.self)
//    }
//}


import UIKit

class PatentProfileController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource, UITextFieldDelegate {


@IBOutlet weak var textBox: UITextField!
@IBOutlet weak var dropDown: UIPickerView!


var list = ["1", "2", "3"]

override func viewDidLoad() {
    super.viewDidLoad()
    dropDown.isHidden = true
    // Do any additional setup after loading the view, typically from a nib.
}

override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
}


public func numberOfComponents(in pickerView: UIPickerView) -> Int{
    return 1

}

public func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int{

    return list.count

}

func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {

    self.view.endEditing(true)
    return list[row]

}

func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {

    self.textBox.text = self.list[row]
    self.dropDown.isHidden = true

}

func textFieldDidBeginEditing(_ textField: UITextField) {

    if textField == self.textBox {
        self.dropDown.isHidden = false
        //if you dont want the users to se the keyboard type:

        textField.endEditing(true)
    }

}
}

