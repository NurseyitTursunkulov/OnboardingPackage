//
//  WalkthroughViewController.swift
//  HelloWorld
//
//  Created by Ruslan Riaboshpaka on 29.12.24.
//

import UIKit
import CHIPageControl

class WalkthroughViewController: UIViewController {
    
    
    @IBOutlet weak var newpageControl: CHIPageControlJaloro!
    
    @IBOutlet weak var roundedButton: UIButton!
    @IBOutlet weak var skipButton2: UIButton!
    @IBOutlet weak var nextButton2: UIButton!
    @IBOutlet var pageControl: UIPageControl!
    var primaryColor : UIColor = UIColor.init(red: 218/255, green: 37/255, blue: 78/255, alpha: 1)
    var secondaryColor : UIColor = UIColor.init(red: 251/255, green: 233/255, blue: 237/255, alpha: 1)
    

    
    var walkthroughPageViewController: WalkthroughPageViewController?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        roundedButton.backgroundColor = primaryColor
        roundedButton.layer.cornerRadius = 25.0
        roundedButton.tintColor = UIColor.white
    
        if let size = pageHeadings?.count{
            if newpageControl != nil{
                newpageControl.numberOfPages = size
                newpageControl.currentPageTintColor = primaryColor
                newpageControl.tintColor = secondaryColor
            }
            
        }
        

    }
    
    override func viewDidAppear(_ animated: Bool) {
      

    }
    
    var pageHeadings : [String]?
    var pageImages : [String]?
    var images : [UIImage?]?
    var pageSubHeadings : [String]?
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "data" {
            // Ensure the destination view controller is of the expected type
            if let destinationVC = segue.destination as? WalkthroughPageViewController {
                // Pass the data
                walkthroughPageViewController = destinationVC
                walkthroughPageViewController?.walkthroughDelegate = self
                destinationVC.pageSubHeadings = pageSubHeadings
                destinationVC.pageHeadings = pageHeadings
                destinationVC.pageImages = pageImages
                destinationVC.images = images
            }
        }
    }
    

    @IBAction func nextButtonClicked(_ sender: Any) {
        print("button click ")
        if let index = walkthroughPageViewController?.currentIndex {
            print("button click \(index)")
            switch index {
            case 0...1:
                walkthroughPageViewController?.forwardPage()
            case 2:
                dismiss(animated: true, completion: nil)
            default: break
            }
        }
        updateUI()
    }
    
    @IBAction func skipButtonClicked(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    func updateUI() {
        if let index = walkthroughPageViewController?.currentIndex {
            switch index {
            case 0...1:
                nextButton2.setTitle("NEXT"
                                    , for: .normal)
                skipButton2.isHidden = false
            case 2:
                nextButton2.setTitle("GET STARTED"
                                    , for: .normal)
                skipButton2.isHidden = true
            default: break
            }
            if newpageControl != nil{
                newpageControl.set(progress: index, animated: false)
            }
            
//            newPageControl.progress = index
//            newPageControl.set(progress: index, animated: false)
        }
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


extension WalkthroughViewController: @preconcurrency WalkthroughPageViewControllerDelegate
{
    func didUpdatePageIndex(currentIndex: Int) {
        updateUI()
    }
}
