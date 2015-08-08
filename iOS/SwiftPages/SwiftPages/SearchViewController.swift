//
//  SearchViewController.swift
//  Vestorly
//
//  Created by Avery Lamp on 8/8/15.
//  Copyright © 2015 Gabriel Alvarado. All rights reserved.
//

import UIKit
import Alamofire

class SearchViewController: UIViewController, UISearchBarDelegate, UITableViewDataSource,UITableViewDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = UIColor(white: 0.2, alpha: 1.0)
        let titleLabel = UILabel(frame: CGRectMake(0, 25, self.view.frame.width, 40))
        titleLabel.text = "Home"
        titleLabel.font = UIFont(name: "Avenir", size: 36)
        titleLabel.textColor = UIColor.whiteColor()
        titleLabel.textAlignment = NSTextAlignment.Center
        self.view.addSubview(titleLabel)
        
        searchBar = UISearchBar(frame: CGRectMake(20, 70, self.view.frame.width - 40, 30))
        searchBar.delegate = self
        searchBar.backgroundColor = UIColor(white: 0.2, alpha: 1.0)
        self.view.addSubview(searchBar)
        
        tableView = UITableView(frame: CGRectMake(0, 100, self.view.frame.width, self.view.frame.height - 100))
        tableView.backgroundColor = UIColor.clearColor()
        self.view.addSubview(tableView)
        tableView.delegate = self
        tableView.dataSource = self
        
        
        let tap = UITapGestureRecognizer(target: self, action: "dismissKeyboard")
        self.view.addGestureRecognizer(tap)
        
        
        // Do any additional setup after loading the view.
    }
    var searchBar:UISearchBar! = nil
    var tableView: UITableView! = nil
    var articlesToDisplay: JSON! = nil

    func searchBarSearchButtonClicked(searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
        let URL = NSURL(string: "https://staging.vestorly.com/api/v2/articles?vestorly_auth=eyJwYXlsb2FkIjoiNTVjNTU0YTA3ZDY4NzhhN2FjMDAwMDAxIiwiY3JlYXRlZF9vbiI6MTQzOTA0NTc5NCwic2lnbmF0dXJlIjoiZGRtaE1ZNFo4c0dFSmdHaVhvZ1lzcVc4VTdGZ1JkaHNkNiswS2ZFYThWST0ifQ&limit=300&text_query=\(searchBar.text!)")
        let mutableURLRequest = NSMutableURLRequest(URL: URL!)
        mutableURLRequest.HTTPMethod  = "GET"
        Alamofire.request(mutableURLRequest).responseJSON(completionHandler: { (req, resp, json, error) -> Void in
            if error !=  nil {
                print("Error")
                print(req)
                print(resp)
                print(error)
            }else{
                print(json)
                if json != nil {
                    self.articlesToDisplay = JSON(json!)
                    self.tableView.reloadSections(NSIndexSet(index: 0), withRowAnimation: UITableViewRowAnimation.Left)

                    
                    
                }
            }
        })
        
        
    }
    
    
    //MARK: table view delegate
    
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if articlesToDisplay != nil {
            return articlesToDisplay.count
        }else{
            return 0
        }
        
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("PostCell") as! PostTableViewCell    

        print(articlesToDisplay[indexPath.row])
        print(articlesToDisplay[indexPath.row]["title"].string!)
        
        cell.title.text = articlesToDisplay[indexPath.row]["title"].string!
        
        
        return cell
    }
    
    
    func dismissKeyboard(){
        searchBar.resignFirstResponder()
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
