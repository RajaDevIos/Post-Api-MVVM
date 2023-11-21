//
//  ViewController.swift
//  MVVMdesign
//
//  Created by Raja.sheikh on 20/11/23.
//

import UIKit

class ViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {
    
    @IBOutlet weak var tableView : UITableView!
    let Viewmodel = ViewModel()
    var data : Root?
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        loadData()
        //        let obj = ViewModel()
        // Do any additional setup after loading the view.
    }
    
    func loadData () {
        let parameters : [String:Any] = [  "year": "2020"]
        Viewmodel.getResponse(urlString: urlConstants.link, parameter: parameters,oncompletion : { (response) in
            
            DispatchQueue.main.async{
                self.data = response
                self.tableView.reloadData()
            }
            
        } ,onerror: { (error) in
            print("Error: \(error.localizedDescription)")
        })
        
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return data?.makeList.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell") as! TableViewCell
        
        cell.nameLable.text = data?.makeList[indexPath.row]
        return cell
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    
    
    
    
}
