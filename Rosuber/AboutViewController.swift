//
//  AboutViewController.swift
//  Rosuber
//
//  Created by FengYizhi on 2018/4/24.
//  Copyright © 2018年 FengYizhi. All rights reserved.
//

import UIKit

class AboutViewController: UIViewController {
    let aboutToHomeSegueIdentifier = "aboutToHomeSegue"
    
    @IBOutlet weak var creditViewTopConstraint: NSLayoutConstraint!
    @IBOutlet weak var creditView: UIView!
    
    @IBOutlet weak var developerOneImageView: UIImageView!
    @IBOutlet weak var developerTwoImageView: UIImageView!
    @IBOutlet weak var instructorImageView: UIImageView!
    @IBOutlet weak var launchImageView: UIImageView!
    
    var imageViews: [UIImageView]!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        creditViewTopConstraint.constant = creditView.frame.height
        imageViews = [developerOneImageView, developerTwoImageView, instructorImageView, launchImageView]
        for view in imageViews {
            view.image = view.image!.withRenderingMode(.alwaysTemplate)
            view.tintColor = UIColor.white
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        creditViewTopConstraint.constant = -20
        UIView.animate(withDuration: 3.0, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseOut, animations: {
            self.view.layoutIfNeeded()
        }, completion: nil)
    }

}
