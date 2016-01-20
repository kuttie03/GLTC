//
//  NewsViewController.swift
//  GLTC
//
//  Created by Shravan Kumar Singireddy on 1/19/16.
//  Copyright © 2016 Darshan Labs. All rights reserved.
//

import UIKit

class NewsViewController: UIViewController, UIPageViewControllerDataSource {

    @IBOutlet weak var menuButton: UIBarButtonItem!
    
    var news: [GLTCNews] = []
    var newsContentViewController: UIPageViewController!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        news = GLTCDataLoader.sharedInstance.getNews()
        if self.revealViewController() != nil {
            var image = UIImage(named: "menu_white")
            image = image?.imageWithRenderingMode(UIImageRenderingMode.AlwaysOriginal)
            self.navigationItem.leftBarButtonItem = UIBarButtonItem(image: image, style: UIBarButtonItemStyle.Plain, target: self.revealViewController(), action: "revealToggle:")
            self.view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())
        }
        self.newsContentViewController = self.storyboard?.instantiateViewControllerWithIdentifier("NewsPageViewController") as! UIPageViewController
        
        self.newsContentViewController.dataSource = self
        
        let initialContenViewController = self.newsAtIndex(0) as NewsContentViewController
        
        let viewControllers = NSArray(object: initialContenViewController)
        
        
        self.newsContentViewController.setViewControllers((viewControllers as! [UIViewController]), direction: UIPageViewControllerNavigationDirection.Forward, animated: true, completion: nil)
        
        //self.newsContentViewController.view.frame = CGRectMake(0, 0, self.view.frame.size.width, //self.view.frame.size.height)
        
        self.addChildViewController(self.newsContentViewController)
        self.view.addSubview(self.newsContentViewController.view)
        self.newsContentViewController.didMoveToParentViewController(self)

    }
    
    func pageViewController(pageViewController: UIPageViewController, viewControllerBeforeViewController viewController: UIViewController) -> UIViewController? {
        let viewController = viewController as! NewsContentViewController
        var index = viewController.pageIndex as Int
        if(index == 0 || index == NSNotFound) {
            return nil
        }
        index--
        return self.newsAtIndex(index)
    }
    
    func pageViewController(pageViewController: UIPageViewController, viewControllerAfterViewController viewController: UIViewController) -> UIViewController? {
        let viewController = viewController as! NewsContentViewController
        var index = viewController.pageIndex as Int
        if((index == NSNotFound)) {
            return nil
        }
        index++
        if(index == news.count) {
            return nil
        }
        return self.newsAtIndex(index)
    }
    
    func presentationCountForPageViewController(pageViewController: UIPageViewController) -> Int {
        return news.count
    }
    
    func presentationIndexForPageViewController(pageViewController: UIPageViewController) -> Int {
        return 0
    }
    
    func newsAtIndex(index: Int) -> NewsContentViewController {
        let pageContentViewController = self.storyboard?.instantiateViewControllerWithIdentifier("NewsContentViewController") as! NewsContentViewController
        pageContentViewController.newsImage = news[index].getNewsImage()
        pageContentViewController.newsTxt = news[index].getNewsText()
        pageContentViewController.pageIndex = index
        return pageContentViewController        
    }
}
