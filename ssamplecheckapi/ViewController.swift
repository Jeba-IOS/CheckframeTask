//
//  ViewController.swift
//  ssamplecheckapi
//
//  Created by Bareeth on 30/04/24.
//

import UIKit
import apicallpackage
class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        ConnectionHandler.shared.getRequest(for: <#T##String#>, APIUrl: <#T##String#>, params: <#T##Parameters#>).responseDecode(to: <#T##T#>, <#T##Closure<T>#>)
        // Do any additional setup after loading the view.
    }


}

