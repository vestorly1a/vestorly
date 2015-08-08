//
//  PostViewControllerNew.swift
//  Vestorly
//
//  Created by Avery Lamp on 8/8/15.
//  Copyright © 2015 Gabriel Alvarado. All rights reserved.
//

import UIKit

class PostViewControllerNew: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        titleStuff.text = titleStr
        bodyContent.text = body

        bodyContent.editable = false
        
        let url = imageStr
        print(url)
        
        if (url != nil){
            let image_url = NSURL(string:"https:\(url!)")
            
            let priority = DISPATCH_QUEUE_PRIORITY_BACKGROUND
            dispatch_async(dispatch_get_global_queue(priority, 0)) {
                // do some task
                let image_data = NSData(contentsOfURL: image_url!)
                
                dispatch_async(dispatch_get_main_queue()) {
                    // update some UI
                    let image = UIImage(data: image_data!)
                    
                    self.coverImage.image = image
                    
                }
            }
        }

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBOutlet weak var coverImage: UIImageView!

    @IBOutlet weak var bodyContent: UITextView!
    
    
    @IBOutlet weak var titleStuff: UILabel!
    
    var titleStr:String! = nil
    var imageStr: String! = nil
    var body: String! = nil
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
