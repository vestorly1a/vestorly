import UIKit
import Bond


class PostTableViewCell: UITableViewCell {
    
    @IBOutlet weak var coverImage: UIImageView!
    
    
    @IBOutlet weak var authorName: UILabel!
    @IBOutlet weak var title: UILabel!
 
    @IBOutlet weak var createdAt: UILabel!
    
    @IBOutlet weak var summary: UILabel!
       
    @IBOutlet weak var authorPic: UIImageView!
    //MARK: Initialization
    
    
    
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    
    }
}