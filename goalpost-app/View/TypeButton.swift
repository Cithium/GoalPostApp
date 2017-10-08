//
//  TypeButton.swift
//  goalpost-app
//
//  Created by Hamza Abdulilah on 2017-10-05.
//  Copyright © 2017 Hamza Abdulilah. All rights reserved.
//

import UIKit

class TypeButton: UIButton {

    override func awakeFromNib() {
        self.layer.cornerRadius = 8.0
        self.clipsToBounds = true
    }

}
