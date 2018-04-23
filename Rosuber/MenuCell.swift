//
//  MenuCell.swift
//  Rosuber
//
//  Created by FengYizhi on 2018/4/22.
//  Copyright © 2018年 FengYizhi. All rights reserved.
//

import UIKit
import Foundation

class MenuCell: UICollectionViewCell {
    
    let button: UIButton = {
        let button = UIButton(type: UIButtonType.system)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.backgroundColor = .white
        button.tintColor = UIColor.black
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 17.0)
        return button
    }()
    
    var menuItem: MenuItem? {
        didSet {
            button.setTitle(menuItem?.title, for: .normal)
            button.setImage(UIImage(named: (menuItem?.image)!), for: .normal)
            button.imageView?.contentMode = .scaleAspectFit
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
//        label.textAlignment = .center
//        label.baselineAdjustment = .alignBaselines
//        label.font = UIFont.boldSystemFont(ofSize: 15.0)
//        label.isUserInteractionEnabled = true
//        label.isEnabled = true
//
//        label.addGestureRecognizer(UIGestureRecognizer(target: self, action: #selector(pressedLabel)))
//        button.tintColor = UIColor.black
//        button.isUserInteractionEnabled = true
//        button.addTarget(self, action: #selector(pressedLabel), for: UIControlEvents.touchUpInside)
//        addSubview(label)
    
//        addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|[v0]|", options: NSLayoutFormatOptions(), metrics: nil, views: ["v0" : label]))
//        addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|[v0]|", options: NSLayoutFormatOptions(), metrics: nil, views: ["v0" : label]))
//        addConstraint(NSLayoutConstraint(item: button, attribute: .centerY, relatedBy: .equal, toItem: self, attribute: .centerY, multiplier: 1, constant: 0))
    }
    
    @objc func pressedLabel() {
        print("tap working")
    }
    
    required init?(coder aDecoder: NSCoder) {
//        fatalError("init(coder:) has not been implemented")
        super.init(coder: aDecoder)
        setupViews()
    }
    
    func setupViews() {
        addSubview(button)
        button.centerXAnchor.constraint(equalTo: contentView.centerXAnchor).isActive = true
        button.centerYAnchor.constraint(equalTo: contentView.centerYAnchor).isActive = true
        button.addTarget(self, action: #selector(pressedLabel), for: .touchUpInside)
    }
}
