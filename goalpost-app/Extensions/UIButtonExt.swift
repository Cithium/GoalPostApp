//
//  UIButtonExt.swift
//  goalpost-app
//
//  Created by Hamza Abdulilah on 2017-10-06.
//  Copyright © 2017 Hamza Abdulilah. All rights reserved.
//

import UIKit

extension UIButton {
    
    func setSelectedColor () {
        self.backgroundColor = #colorLiteral(red: 0.4922404289, green: 0.7722371817, blue: 0.4631441236, alpha: 1)
        
    }
    
    func setDeselectedColor() {
        self.backgroundColor = #colorLiteral(red: 0.8823529412, green: 0.8823529412, blue: 0.8823529412, alpha: 1)
    }
}
