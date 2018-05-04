//
//  FindTripDetailViewController.swift
//  Rosuber
//
//  Created by FengYizhi on 2018/4/24.
//  Copyright © 2018年 FengYizhi. All rights reserved.
//

import UIKit

class FindTripDetailViewController: UIViewController {
    let findDetailToFindSegueIdentifier = "findDetailToFindSegue"
    
    var trip: Trip?

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func pressedMenu(_ sender: Any) {
        let actionController = UIAlertController(title: "Find Trip Options", message: nil, preferredStyle: .actionSheet)
        
        actionController.addAction(UIAlertAction(title: "Contact Driver", style: .default, handler: { _ in
            print("pressed contact driver")
        }))
        actionController.addAction(UIAlertAction(title: "Contact Passenger(s)", style: .default, handler: { _ in
            print("pressed contact passenger(s)")
        }))
        
        actionController.addAction(UIAlertAction(title: "Join", style: .default, handler: { _ in
            print("pressed join")
        }))
        
        actionController.addAction(UIAlertAction.init(title: "Cancel", style: .cancel, handler: nil))
        present(actionController, animated: true)
    }
    
}
