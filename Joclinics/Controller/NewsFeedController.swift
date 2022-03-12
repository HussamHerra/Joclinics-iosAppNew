

import UIKit

class NewsFeedController: UIViewController , UITableViewDelegate,  UITableViewDataSource {
    var listOfPosts : [NewsFeedData] = []
    var newsFeed = DoctorManager()
    let refreshControl = UIRefreshControl()
    var endList = false
    @IBOutlet weak var tableview: UITableView!
//    let tableview: UITableView = {
//        let tv = UITableView()
//        tv.backgroundColor = .white
//        tv.translatesAutoresizingMaskIntoConstraints = false
//        return tv
//    }()
    override func viewDidLoad() {
        super.viewDidLoad()
        
        newsFeed.newsFeedDelegate = self
        tableview.delegate = self
        tableview.dataSource = self
        refreshControl.attributedTitle = NSAttributedString(string: "Reload")
        refreshControl.addTarget(self, action: #selector(self.refresh(_:)), for: .valueChanged)
        refreshControl.tintColor = .black
        newsFeed.getNewsFeed(num: 0)
//        self.tableview.rowHeight = UITableView.automaticDimension;
//        self.tableview.estimatedRowHeight = 30;
    }
    func setUpTableView(){
        tableview.register(NewsFeedTableViewCell.nib(), forCellReuseIdentifier: NewsFeedTableViewCell.identifier)
        tableview.backgroundColor = UIColor.white
//        view.addSubview(tableview)
//        NSLayoutConstraint.activate([
//            tableview.topAnchor.constraint(equalTo: self.view.topAnchor),
//            tableview.bottomAnchor.constraint(equalTo: self.view.bottomAnchor),
//            tableview.rightAnchor.constraint(equalTo: self.view.rightAnchor),
//            tableview.leftAnchor.constraint(equalTo: self.view.leftAnchor)
//        ])
        tableview.addSubview(refreshControl)
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return listOfPosts.count;
    }
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if indexPath.row + 1 == listOfPosts.count && !endList {
            newsFeed.getNewsFeed(num: listOfPosts.count)
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableview.dequeueReusableCell(withIdentifier: NewsFeedTableViewCell.identifier, for: indexPath) as! NewsFeedTableViewCell
        if indexPath.row < listOfPosts.count {
            cell.configure(with: listOfPosts[indexPath.row])
        }
        return cell
    }
    @objc func refresh(_ sender: AnyObject) {
        listOfPosts = []
        self.endList = false
        newsFeed.getNewsFeed(num: 0)
    }
}
extension NewsFeedController : NewsFeedManagerDelegate {
    func didFailWithError() {
        DispatchQueue.main.async {
            print("fail with error")
        }
    }
    func didReturnNewsFeed(newsFeeds: [NewsFeedData]) {
        DispatchQueue.main.async {
            if newsFeeds.isEmpty {
                self.endList = true
            }
            self.listOfPosts.append(contentsOf: newsFeeds)
            self.tableview.reloadData()
            self.setUpTableView()
            self.refreshControl.endRefreshing()
        }
    }
}
