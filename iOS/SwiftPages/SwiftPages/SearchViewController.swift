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
        tableView.registerClass(UITableViewCell.self, forCellReuseIdentifier: "cell")
        
        let tap = UITapGestureRecognizer(target: self, action: "dismissKeyboard")
        self.view.addGestureRecognizer(tap)
        
        loadAllArticles()
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
    
    func loadAllArticles(){
        let URL = NSURL(string: "https://staging.vestorly.com/api/v2/articles?vestorly_auth=eyJwYXlsb2FkIjoiNTVjNTU0YTA3ZDY4NzhhN2FjMDAwMDAxIiwiY3JlYXRlZF9vbiI6MTQzOTA0NTc5NCwic2lnbmF0dXJlIjoiZGRtaE1ZNFo4c0dFSmdHaVhvZ1lzcVc4VTdGZ1JkaHNkNiswS2ZFYThWST0ifQ&limit=300")
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
            print(articlesToDisplay["articles"].count)
            return articlesToDisplay["articles"].count
        }else{
            return 0
        }
        
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 300
        
        
    }
    
    var selectedCell: NSIndexPath! = nil
    
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("cell")
        
        for view in cell!.subviews{
            view.removeFromSuperview()
        }
        
        print(articlesToDisplay["articles"][indexPath.row]["title"].string!)
        
        cell?.backgroundColor = UIColor.clearColor()
        
        let titleLabel = UILabel(frame: CGRectMake(0, 210, (cell?.frame.width)!, 80))
        titleLabel.text = articlesToDisplay["articles"][indexPath.row]["title"].string!
        titleLabel.textColor = UIColor.whiteColor()
        titleLabel.font = UIFont(name: "Panton-Bold", size: 40)
        titleLabel.textAlignment = NSTextAlignment.Center
        titleLabel.numberOfLines = 2
        titleLabel.lineBreakMode = NSLineBreakMode.ByWordWrapping
        cell?.addSubview(titleLabel)
        
        let summary = UILabel(frame: CGRectMake(0, 290, cell!.frame.width, 70))
        summary.textColor = UIColor.whiteColor()
        summary.alpha = 0.8
        summary.text = articlesToDisplay["articles"][indexPath.row]["summary"].string!
        summary.numberOfLines = 0
        summary.lineBreakMode = NSLineBreakMode.ByWordWrapping
        if selectedCell != nil {
            if selectedCell.row == indexPath.row{
                    cell?.addSubview(summary)
            }
        }


        
        
        let url = articlesToDisplay["articles"][indexPath.row]["image_url"].string
        print(url)
        let coverImage = UIImageView(frame: CGRectMake(0, 0, cell!.frame.width, 200))
        coverImage.backgroundColor = UIColor.lightGrayColor()
        coverImage.contentMode = UIViewContentMode.ScaleAspectFill
        coverImage.layer.masksToBounds = true
        cell?.addSubview(coverImage)
        
        if (url != nil){
            let image_url = NSURL(string:"https:\(url!)")
            
            let priority = DISPATCH_QUEUE_PRIORITY_BACKGROUND
            dispatch_async(dispatch_get_global_queue(priority, 0)) {
                // do some task
                let image_data = NSData(contentsOfURL: image_url!)
                
                dispatch_async(dispatch_get_main_queue()) {
                    // update some UI
                    let image = UIImage(data: image_data!)
                    
                    coverImage.image = image
                    
                }
            }
        }
        
        
        return cell!
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        selectedCell = indexPath
        tableView.reloadData()
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
