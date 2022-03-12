import UIKit

class PatentClinicsController: UIViewController , UITableViewDelegate,  UITableViewDataSource{
    
    @IBOutlet weak var filterStack: UIStackView!
    let refreshControl = UIRefreshControl()
    var endList = false
    @IBOutlet weak var pleaseWait: UIView!
    @IBOutlet weak var filterContainer: UIView!
    @IBOutlet weak var sortClinics: UIView!
    @IBOutlet weak var cityFilterContainer: UIView!
    var patentFilter = PatentFilterController();
    var filterType = FilterStruct();
    var clinicsManager = ClinicsManager()
    var clinicsData  : [Clinics] = []
    var clasificationFilter = "الكل"
    var sortFilter = "التقييم"
    var cityFilter = "الكل"
    var log : Float = 0.0
    var lat : Float = 0.0
    
    @IBOutlet weak var tableView2: UITableView!
    
    
    let tableview: UITableView = {
        let tv = UITableView()
        tv.backgroundColor = .white
        tv.translatesAutoresizingMaskIntoConstraints = false
        return tv
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        let langStr = Locale.current.languageCode
        pleaseWait.isHidden = false
        clinicsManager.delegate = self
        clinicsManager.getClinics()
        tableView2.dataSource = self
        tableView2.delegate = self
        refreshControl.attributedTitle = NSAttributedString(string: "Reload")
        refreshControl.addTarget(self, action: #selector(self.refresh(_:)), for: .valueChanged)
        refreshControl.tintColor = .black
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
        view.endEditing(true)
    }
    func setUpTableView(){
        tableView2.register(ClinicsTableViewCell.nib(), forCellReuseIdentifier: ClinicsTableViewCell.identifier)
        tableView2.backgroundColor = UIColor.white
        tableView2.addSubview(refreshControl)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return clinicsData.count
    }
    
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView2.dequeueReusableCell(withIdentifier: ClinicsTableViewCell.identifier, for: indexPath) as! ClinicsTableViewCell
        if indexPath.row < clinicsData.count {
            cell.configure(with: clinicsData[indexPath.row])
        }
        cell.delegate = self
        return cell
    }
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if indexPath.row + 1 == clinicsData.count && !endList {
            clinicsManager.getClinicFilter(classfic: clasificationFilter, city: cityFilter, sort: sortFilter, num: clinicsData.count, lat: self.lat, log: self.log)
        }
    }
    @objc func refresh(_ sender: AnyObject) {
        clinicsData = []
        self.endList = false
        clinicsManager.getClinics()
    }
}
extension PatentClinicsController : ClinicsManagerDelegate{
    func didGetClinics(clinics: [Clinics]) {
        DispatchQueue.main.async {
            self.clinicsData.append(contentsOf: clinics)
            self.pleaseWait.isHidden = true
            self.setUpTableView()
            self.tableView2.reloadData()
            self.refreshControl.endRefreshing()
        }
    }
    func didFailWithError() {
        DispatchQueue.main.async {
            self.pleaseWait.isHidden = true
            print("from error")
            self.showToast(message: "يرجى التأكد من الاتصال بالانترنت")
        }
    }
}
extension PatentClinicsController : ClinicsTableViewCellDelegate{
    func didTapButton() {
        DispatchQueue.main.async {
            self.view.endEditing(true)
            self.RestAllContainer()
        }
    }
}
