
import UIKit

class PatentProfileController: UIViewController {
    var patent : Patent!
    @IBOutlet weak var userName: UILabel!
    @IBOutlet weak var firstLastName: UILabel!
    let preferences = UserDefaults.standard
    override func viewDidLoad() {
        super.viewDidLoad()
        let jsonString = preferences.string(forKey: "Patent")
        if let dataFromJsonString = jsonString?.data(using: .utf8) {
            do{
                patent = try JSONDecoder().decode(Patent.self,from: dataFromJsonString)
                userName.text = patent!.UserName
                firstLastName.text = "\(patent!.FirstName) \(patent!.LastName)"
                //print(patent!)
            }
            catch{
                print("error")
            }
        }
    }
    @IBAction func logOut(_ sender: UIButton) {
        preferences.removeObject(forKey: "Patent")
        preferences.synchronize()
        self.dismiss(animated: true, completion: nil)
        self.performSegue(withIdentifier: "test", sender: self.self)
    }
}
