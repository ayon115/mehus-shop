//
//  TutorialController.swift
//  mehus-shop
//
//  Created by Ashiq Uz Zoha on 17/10/23.
//

import UIKit
import ActionKit

class TutorialController: UIViewController {

    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var skipButton: UIButton!
    
    var pageController: UIPageViewController?
    var pageContents: [UIViewController] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.pageController = UIPageViewController(transitionStyle: .scroll, navigationOrientation: .horizontal)
        
        if let pageController = self.pageController {
            self.addChild(pageController)
            self.containerView.addSubview(pageController.view)
            pageController.view.frame = self.containerView.bounds
            pageController.didMove(toParent: self)
        }
        
        
        self.createPages()
        self.pageController?.setViewControllers([self.pageContents[0]], direction: .forward, animated: true)
        self.pageController?.dataSource = self
        self.pageController?.delegate = self
        
        let pageControlAppearence = UIPageControl.appearance()
        pageControlAppearence.currentPageIndicatorTintColor = UIColor(named: "theme500")!
        pageControlAppearence.pageIndicatorTintColor = UIColor(named: "theme500")!.withAlphaComponent(0.3)
        
        self.skipButton.applyCorner(cornerRadius: 5.0, borderWidth: 1.0, borderColor: .lightGray)
        self.skipButton.addControlEvent(.touchUpInside) {
            
            if let currentWindowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene {
                if let sceneDelegate = currentWindowScene.delegate as? SceneDelegate, let window = sceneDelegate.window {
                    // print(window.rootViewController)
                    
                    if let authViewController = self.storyboard?.instantiateViewController(withIdentifier: Constants.authNavigationController) as? UINavigationController {
                        
                        let userDefaults = UserDefaults.standard
                        userDefaults.set(true, forKey: "tutorialSeen")
                        userDefaults.synchronize()
                        
                        window.rootViewController = authViewController
                    }
                }
            }
        }
        
    }
    
    func createPages () {
        let page1 = self.storyboard?.instantiateViewController(identifier: Constants.tutorialContentController) as! TutorialContentController
        let page2 = self.storyboard?.instantiateViewController(identifier: Constants.tutorialContentController) as! TutorialContentController
        let page3 = self.storyboard?.instantiateViewController(identifier: Constants.tutorialContentController) as! TutorialContentController
        
        let pageData1 = Page(title: "Brand New Products", description: "Choose brand new products from a variety of collections.", image: UIImage(named: "product")!, pageIndex: 0)
        let pageData2 = Page(title: "Add To Cart With Ease", description: "Choose from product and add them to Cart easily in a few seconds.", image: UIImage(named: "cart")!, pageIndex: 1)
        let pageData3 = Page(title: "Checkout Fast", description: "Checkout fast with your preferred payment menthod. We support a lot of them.", image: UIImage(named: "checkout")!, pageIndex: 2)
        
        page1.page = pageData1
        page2.page = pageData2
        page3.page = pageData3
        
        self.pageContents = [page1, page2, page3]
    }
    
}

extension TutorialController: UIPageViewControllerDataSource, UIPageViewControllerDelegate {
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        
        if let controller = viewController as? TutorialContentController {
            print("viewControllerBefore pageIndex = \(controller.page.pageIndex)")
            if controller.page.pageIndex == 0 {
                return nil
            } else {
                return self.pageContents[controller.page.pageIndex - 1]
            }
        }
        return nil
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        
        if let controller = viewController as? TutorialContentController {
            print("viewControllerAfter pageIndex = \(controller.page.pageIndex)")
            
            if controller.page.pageIndex == (self.pageContents.count - 1) {
                return nil
            } else {
                return self.pageContents[controller.page.pageIndex + 1]
            }
        }
        
        return nil
    }
    
    func presentationCount(for pageViewController: UIPageViewController) -> Int {
        return self.pageContents.count
    }
    
    func presentationIndex(for pageViewController: UIPageViewController) -> Int {
        return 0
    }
    
    
}
