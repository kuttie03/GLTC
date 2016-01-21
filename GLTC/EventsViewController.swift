//
//  EventsViewController.swift
//  GLTC
//
//  Created by Shravan Kumar Singireddy on 1/20/16.
//  Copyright © 2016 Darshan Labs. All rights reserved.
//

import UIKit

class EventsViewController: UIViewController, UIPageViewControllerDataSource {

    @IBOutlet weak var menuButton: UIBarButtonItem!
    
    var events: [GLTCEvent] = []
    var eventsContentViewController: UIPageViewController!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        events = GLTCDataLoader.sharedInstance.getEvents()
        if self.revealViewController() != nil {
            var image = UIImage(named: "menu_white")
            image = image?.imageWithRenderingMode(UIImageRenderingMode.AlwaysOriginal)
            self.navigationItem.leftBarButtonItem = UIBarButtonItem(image: image, style: UIBarButtonItemStyle.Plain, target: self.revealViewController(), action: "revealToggle:")
            self.view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())
        }
        self.eventsContentViewController = self.storyboard?.instantiateViewControllerWithIdentifier("EventsPageViewController") as! UIPageViewController
        
        self.eventsContentViewController.dataSource = self
        
        let initialContenViewController = self.eventAtIndex(0) as EventsContentViewController
        
        let viewControllers = NSArray(object: initialContenViewController)
        
        
        self.eventsContentViewController.setViewControllers((viewControllers as! [UIViewController]), direction: UIPageViewControllerNavigationDirection.Forward, animated: true, completion: nil)
        
        self.addChildViewController(self.eventsContentViewController)
        self.view.addSubview(self.eventsContentViewController.view)
        self.eventsContentViewController.didMoveToParentViewController(self)
        
    }
    
    func pageViewController(pageViewController: UIPageViewController, viewControllerBeforeViewController viewController: UIViewController) -> UIViewController? {
        let viewController = viewController as! EventsContentViewController
        var index = viewController.pageIndex as Int
        if(index == 0 || index == NSNotFound) {
            return nil
        }
        index--
        return self.eventAtIndex(index)
    }
    
    func pageViewController(pageViewController: UIPageViewController, viewControllerAfterViewController viewController: UIViewController) -> UIViewController? {
        let viewController = viewController as! EventsContentViewController
        var index = viewController.pageIndex as Int
        if((index == NSNotFound)) {
            return nil
        }
        index++
        if(index == events.count) {
            return nil
        }
        return self.eventAtIndex(index)
    }
    
    func presentationCountForPageViewController(pageViewController: UIPageViewController) -> Int {
        return events.count
    }
    
    func presentationIndexForPageViewController(pageViewController: UIPageViewController) -> Int {
        return 0
    }
    
    func eventAtIndex(index: Int) -> EventsContentViewController {
        let pageContentViewController = self.storyboard?.instantiateViewControllerWithIdentifier("EventsContentViewController") as! EventsContentViewController
        if(events.count > 0){
            pageContentViewController.eventImage = events[index].getEventImage()
        }
        pageContentViewController.pageIndex = index
        return pageContentViewController
    }
}
