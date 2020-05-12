//
//  TransitionProtocols.swift
//  tryTwo
//
//  Created by fivecoil on 30/04/2020.
//  Copyright © 2020 fivecoil. All rights reserved.
//

import UIKit

//MARK: - Transitions Protocol
//Реализуется View,ссылка у Router
protocol ModuleTransitionable: class {
    
    //present
    func presentModule(module: UIViewController, animation: Bool, completion: (() -> Void)?)
    
    //dismiss
    func dismissView(animation: Bool, completion: (() -> Void)?)
    
    //navigation push
    func pushModule(module: UIViewController, animation: Bool)
    
    //navigation pop
    func popModule(animation: Bool)
    
}

extension ModuleTransitionable where Self: UIViewController {
    
    func presentModule(module: UIViewController, animation: Bool, completion: (() -> Void)?) {
        self.present(module, animated: animation, completion: completion)
    }
    
    func dismissView(animation: Bool, completion: (() -> Void)?) {
        self.dismiss(animated: animation, completion: completion)
    }
    
    func pushModule(module: UIViewController, animation: Bool) {
        self.navigationController?.pushViewController(module, animated: true)
    }
    
    func popModule(animation: Bool) {
        self.navigationController?.popViewController(animated: animation)
    }

}


