//
//  WalkthroughContentViewController.swift
//  HelloWorld
//
//  Created by Ruslan Riaboshpaka on 29.12.24.
//

import UIKit

class WalkthroughContentViewController: UIViewController {
    
    @IBOutlet var headingLabel: UILabel! {
        didSet {
            headingLabel.numberOfLines = 0
        }
    }
    @IBOutlet var subHeadingLabel: UILabel! {
        didSet {
            subHeadingLabel.numberOfLines = 0
        }
    }
    @IBOutlet var contentImageView: UIImageView!
    var index = 0
    var heading = ""
    var subHeading = ""
    var imageFile =    ""
    var image : UIImage?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        headingLabel.text = heading
        subHeadingLabel.text = subHeading
//        contentImageView.image = UIImage(named: imageFile)
//        URLSession.shared.dataTask(with: URL(string: imageFile)!) { (data, response, error) in
//                    if let data = data, let image = UIImage(data: data) {
//                        DispatchQueue.main.async {
//                            // Update the UIImageView on the main thread
//                            self.contentImageView.image = image
//                        }
//                    }
//                }.resume()
        contentImageView.image = image
        print("content view controller" + heading)
        // Do any additional setup after loading the view.
    }
    
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destination.
     // Pass the selected object to the new view controller.
     }
     */
    
}
