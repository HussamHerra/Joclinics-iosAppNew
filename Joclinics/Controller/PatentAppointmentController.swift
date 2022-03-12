//
//  PatentAppointmentController.swift
//  Joclinics
//
//  Created by Hussam Abuherra on 28/11/2021.
//

import UIKit

class PatentAppointmentController: UIViewController , UITableViewDelegate , UITableViewDataSource {
    @IBOutlet weak var tableview: UITableView!
    var patentAppointments : [Appointment] = []
    let preferences = UserDefaults.standard
    let refreshControl = UIRefreshControl()
    var patentId : Int = 0
    var patentData : Patent?
    var appointmentManager = AppointmentManager()
    override func viewDidLoad() {
        super.viewDidLoad()
        tableview.delegate = self
        tableview.dataSource = self
        appointmentManager.delegate = self
        refreshControl.attributedTitle = NSAttributedString(string: "Reload")
        refreshControl.addTarget(self, action: #selector(self.refresh(_:)), for: .valueChanged)
        refreshControl.tintColor = .black
        tableview.register(AppointmentTableViewCell.nib(), forCellReuseIdentifier: AppointmentTableViewCell.identifier)
        tableview.backgroundColor = UIColor.white
        tableview.addSubview(refreshControl)
        
        
        let jsonString = preferences.string(forKey: "Patent")
        let dataFromJsonString = (jsonString?.data(using: .utf8))!
        
        do{
            patentData = try JSONDecoder().decode(Patent.self, from: dataFromJsonString)
            patentId = patentData!.ID
            print("patentId : " , patentId)
        }
        catch{
            print("from the error")
        }
        appointmentManager.getPatentAppointment(id: patentId)
        
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return patentAppointments.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableview.dequeueReusableCell(withIdentifier: AppointmentTableViewCell.identifier, for: indexPath) as! AppointmentTableViewCell
        cell.configure(with: patentAppointments[indexPath.row])
        print("gender : " , patentAppointments[indexPath.row].doctorGender)
        return cell
    }
    @objc func refresh(_ sender: AnyObject) {
        print("refreshed")
        patentAppointments = []
        appointmentManager.getPatentAppointment(id: patentId)
    }
}

extension PatentAppointmentController : AppointmentManagerDelegate {
    func didGetAppointment(appointment: [Appointment]) {
        DispatchQueue.main.async {
            self.patentAppointments.append(contentsOf: appointment)
            self.refreshControl.endRefreshing()
            self.tableview.reloadData()
//            print(self.patentAppointments)
        }
    }
    
    func didFailWithError() {
        DispatchQueue.main.async {
            print("from error")
        }
    }
}
