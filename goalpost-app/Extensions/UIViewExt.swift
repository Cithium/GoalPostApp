//
//  UIViewExt.swift
//  goalpost-app
//
//  Created by Hamza Abdulilah on 2017-10-06.
//  Copyright © 2017 Hamza Abdulilah. All rights reserved.
//

import UIKit

extension UIView {
    // This extension we are binding the NEXT Button to keyboard, so it slides up with the keyboard.
    //keyboard will change func is triggered once keyboard is about to be used
    func bindToKeyBoard() {
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillChange(_:)), name: NSNotification.Name.UIKeyboardWillChangeFrame, object: nil)
    }
    
    
    //THIS WILL BIND AN OBJECT (SUCH AS A BUTTON) TO THE KEYBOARD WHEN IT POPS UP
    @objc func keyboardWillChange (_ notification: NSNotification) {
        let duration = notification.userInfo![UIKeyboardAnimationDurationUserInfoKey] as! Double //force cast
        let curve = notification.userInfo![UIKeyboardAnimationCurveUserInfoKey] as! UInt
        let beginFrame = (notification.userInfo![UIKeyboardFrameBeginUserInfoKey] as! NSValue).cgRectValue
        let endFrame = (notification.userInfo![UIKeyboardFrameEndUserInfoKey] as! NSValue).cgRectValue
        
        let deltaY = endFrame.origin.y - beginFrame.origin.y
        
        UIView.animateKeyframes(withDuration: duration, delay: 0.0, options: UIViewKeyframeAnimationOptions(rawValue: curve), animations: {self.frame.origin.y += deltaY}, completion: nil)
    }
}
