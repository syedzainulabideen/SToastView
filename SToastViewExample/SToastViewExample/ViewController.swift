//
//  ViewController.swift
//  SToastViewExample
//
//  Created by Syed Zainulabideen on 17/08/2023.
//

import UIKit
import SToastView

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    @IBAction func showErrorButtonPressed(sender: UIButton) {
        let toast = SToastView()
        var config = ToastConfiguration.failureConfig
        config.rightButtonText = "Retry"
        toast.show(withMessage: "Error Occured", description: "Somethings went wrong please try again.", configuration: config) {
            
        }
    }
    
    @IBAction func showSuccessButtonPressed(sender: UIButton) {
        let toast = SToastView()
        toast.show(withMessage: "Success", description: "File uploaded successfully.", direction: .bottom) {
            
        }
    }
    
    @IBAction func showWarningButtonPressed(sender: UIButton) {
        let toast = SToastView()
        var config = ToastConfiguration.warningConfig
        toast.show(withMessage: "Success", description: "File uploaded successfully.", configuration: config, direction: .bottom) {
            
        }
    }
}

