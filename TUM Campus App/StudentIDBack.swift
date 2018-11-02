//
//  StudentIDBack.swift
//  Campus
//
//  Created by Tim Gymnich on 11/1/18.
//  Copyright © 2018 LS1 TUM. All rights reserved.
//

import UIKit

class StudentIDBack: UIView {
    
    @IBOutlet weak var barcodeView: UIImageView!
    @IBOutlet weak var bibliotheksnummerLabel: UILabel!
    

    override func draw(_ rect: CGRect) {
        self.layer.cornerRadius = 8
        self.layer.masksToBounds = true
    }

}
