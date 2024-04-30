//
//  ViewController.swift
//  ssamplecheckapi
//
//  Created by Bareeth on 30/04/24.
//

import UIKit
import apicallpackage
class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return category.recipes.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "samplecell", for: indexPath) as! samplecell
        cell.dummylbl.text = category.recipes[indexPath.row].name
        return cell
        
    }
    

    
    @IBOutlet weak var sampletableview : UITableView!
    var category = SellProductCategoryModel()

    override func viewDidLoad() {
        super.viewDidLoad()
        self.sampletableview.delegate = self
        self.sampletableview.dataSource = self
        getCategory{ result in
            
            switch result{
            case .success(let data):
                dump(data)
                self.category = data
                self.sampletableview.reloadData()
            case .failure(let error): break
                
            }
            // Do any additional setup after loading the view.
        }
    }
    func getCategory(_ result : @escaping Closure<Result<SellProductCategoryModel,Error>>) {
            var param = JSON()
            //param["token"] = UserDefaults.standard.string(forKey: USER_ACCESS_TOKEN)
        ConnectionHandler.shared.getRequest(for: "recipes", APIUrl: "https://dummyjson.com/", params: JSON()).responseDecode(to: SellProductCategoryModel.self, {(json) in
                result(.success(json))
        print(json)
            }).responseFailure({ (error) in
                //result(.failure(CommonError.failure(error)))
            })
        }
}

class samplecell : UITableViewCell{
    
    
    @IBOutlet weak var dummylbl : UILabel!
}
