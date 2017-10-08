//
//  UIViewControllerExt.swift
//  goalpost-app
//
//  Created by Hamza Abdulilah on 2017-10-06.
//  Copyright © 2017 Hamza Abdulilah. All rights reserved.
//

import UIKit

// Här så i princip overridar vi funktionerna för animering för klassen viewcontroller, gör det antingen snyggare eller så som vi vill
extension UIViewController {
    
    func presentDetail(_ viewControllerToPresent: UIViewController) {
        
        let transition = CATransition()
        transition.duration = 0.3
        transition.type = kCATransitionPush
        transition.subtype = kCATransitionFromRight
        self.view.window?.layer.add(transition, forKey: kCATransition)
        
        present(viewControllerToPresent, animated: false, completion: nil)
        
    }
    
    func dismissDetail() {
    
    let transition = CATransition()
    transition.duration = 0.3
    transition.type = kCATransitionPush
    transition.subtype = kCATransitionFromLeft
    self.view.window?.layer.add(transition, forKey: kCATransition)
    
    dismiss(animated: false, completion: nil)
    
    }
    
    func presentSecondaryDetail(__ viewControllerToPresent: UIViewController) {
        
        let transition = CATransition()
        transition.duration = 0.3
        transition.type = kCATransitionPush
        transition.subtype = kCATransitionFromRight
       
        guard let presentedViewController = presentedViewController else { return }
        
        presentedViewController.dismiss(animated: false) {
            self.view.layer.add((transition), forKey: kCATransition)
            self.present(viewControllerToPresent, animated: false, completion: nil)
        }
        
    }

}
