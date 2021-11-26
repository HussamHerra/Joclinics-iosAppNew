import UIKit

class ClinicsSortController: UIViewController , UITableViewDelegate,  UITableViewDataSource{
    var list : [String] = FilterStruct().sortList
    let tableview: UITableView = {
        let tv = UITableView()
        tv.backgroundColor = UIColor.white
        tv.translatesAutoresizingMaskIntoConstraints = false
        return tv
    }()
    let titleLable: UILabel = {
        let label = UILabel()
        label.textColor = UIColor.black
        label.font = UIFont.boldSystemFont(ofSize: 15)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "الترتيب"
        return label
    }()
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.layer.borderWidth = 2
        self.view.layer.borderColor = UIColor.gray.cgColor
        self.view.layer.cornerRadius = 20
        setupTableView()
    }
    func setupTableView() {
        tableview.delegate = self
        tableview.dataSource = self
        tableview.register(ClinicsFilterTableViewCell.nib(), forCellReuseIdentifier: ClinicsFilterTableViewCell.identifier)
        view.addSubview(titleLable)
        NSLayoutConstraint.activate([
            titleLable.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            titleLable.topAnchor.constraint(equalTo: self.view.topAnchor , constant: 10.0),
        ])
        view.addSubview(tableview)
        NSLayoutConstraint.activate([
            tableview.topAnchor.constraint(equalTo: titleLable.bottomAnchor , constant: 10.0),
            tableview.bottomAnchor.constraint(equalTo: self.view.bottomAnchor),
            tableview.rightAnchor.constraint(equalTo: self.view.rightAnchor),
            tableview.leftAnchor.constraint(equalTo: self.view.leftAnchor)
        ])
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return list.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableview.dequeueReusableCell(withIdentifier: ClinicsFilterTableViewCell.identifier, for: indexPath) as! ClinicsFilterTableViewCell
        cell.delegate = self
        cell.configure(with: list[indexPath.row])
        cell.backgroundColor = UIColor.white
        return cell
    }
}
extension ClinicsSortController : ClinicsFilterTableViewCellDelegate{
    func didTapButton(with title: String) {
        print(title)
    }
}
