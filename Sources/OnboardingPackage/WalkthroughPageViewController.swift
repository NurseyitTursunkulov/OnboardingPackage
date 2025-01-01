//
//  WalkthroughPageViewController.swift
//  HelloWorld
//
//  Created by Ruslan Riaboshpaka on 29.12.24.
//

import UIKit

protocol WalkthroughPageViewControllerDelegate: AnyObject {
    func didUpdatePageIndex(currentIndex: Int)
}

class WalkthroughPageViewController: UIPageViewController {
    
    var pageHeadings : [String]?
    var pageImages : [String]?
    var images : [UIImage?]?
    var pageSubHeadings : [String]?
    var currentIndex = 0
    
    weak var walkthroughDelegate: WalkthroughPageViewControllerDelegate?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        delegate = self
        dataSource = self
        // Create the first walkthrough screen
        if let startingViewController = contentViewController(at: 0) {
            setViewControllers([startingViewController], direction: .forward,
                               animated: true, completion: nil)
        }
        
        // Do any additional setup after loading the view.
    }
    
    
    func forwardPage() {
        currentIndex += 1
        if let nextViewController = contentViewController(at: currentIndex) {
            setViewControllers([nextViewController], direction: .forward, animated: true, completion: nil)
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

extension WalkthroughPageViewController: UIPageViewControllerDataSource {
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController?
    {
        var index = (viewController as! WalkthroughContentViewController).index
        index -= 1
        return contentViewController(at: index)
    }
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        var index = (viewController as! WalkthroughContentViewController).index
        index += 1
        return contentViewController(at: index)
    }
    
    
    func contentViewController(at index: Int) -> WalkthroughContentViewController? {
        print("page view controler ...")
        if index < 0 || index >= pageHeadings?.count ?? 0 {
            return nil
        }
        // Create a new view controller and pass suitable data.
        let storyboard = UIStoryboard(name: "Onboarding", bundle: nil)
        if let pageContentViewController = storyboard.instantiateViewController(withIdentifier: "WalkthroughContentViewController") as? WalkthroughContentViewController {
            pageContentViewController.imageFile = pageImages?[index] ?? "emtpy"
            if let myImage = images?[index] {
                pageContentViewController.image = myImage
            }
            
            pageContentViewController.heading = pageHeadings?[index] ?? "emtpy"
            pageContentViewController.subHeading = pageSubHeadings?[index] ?? "emtpy"
            pageContentViewController.index = index
            print("pageContentViewController ...")
            return pageContentViewController
        }
        return nil
    }
}


extension WalkthroughPageViewController: UIPageViewControllerDelegate {
    func pageViewController(_ pageViewController: UIPageViewController, didFinishAnimating finished: Bool, previousViewControllers: [UIViewController], transitionCompleted completed: Bool) {
        if completed {
            if let contentViewController = pageViewController.viewControllers?.first as? WalkthroughContentViewController {
                currentIndex = contentViewController.index
                walkthroughDelegate?.didUpdatePageIndex(currentIndex: contentViewController.index)
            }
        }
    }
}
