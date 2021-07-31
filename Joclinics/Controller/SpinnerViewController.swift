//
//  SpinnerViewController.swift
//  Joclinics
//
//  Created by Hussam on 16/04/2021.
//

import UIKit

class SpinnerViewController: UIViewController {

    @IBOutlet weak var spinnerOutlit: UIActivityIndicatorView!
    override func viewDidLoad() {
        super.viewDidLoad()
        spinnerOutlit.color = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        spinnerOutlit.startAnimating()
    }
}
