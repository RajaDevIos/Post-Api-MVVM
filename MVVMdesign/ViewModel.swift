//
//  ViewModel.swift
//  MVVMdesign
//
//  Created by Raja.sheikh on 20/11/23.
//

import UIKit

class ViewModel: NSObject {

    func getResponse(urlString:String,parameter:[String:Any],oncompletion:@escaping(Root)-> Void,onerror:@escaping (Error) -> Void) {
        
        guard let url = URL(string: urlString) else {return}
        
        var request = URLRequest(url: url)
        request.httpMethod = "Post"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        
        do {
            request.httpBody = try JSONSerialization.data(withJSONObject: parameter,options: .prettyPrinted)
        }
        catch let error  {
            print(error.localizedDescription)
            return
        }
        
        let task = URLSession.shared.dataTask(with: request) {
            (Data,reponse,error)in
            
            guard error == nil else {return}
            guard let dat = Data else {return}
            
            do {
                let content = try JSONDecoder().decode(Root.self, from: dat)
                oncompletion(content)
            }
            catch {
                onerror(error)
                print(error)
            }
        }
        task.resume()
    }
    
}
