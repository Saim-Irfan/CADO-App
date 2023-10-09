//
//  ViewController.swift
//  Cado-App
//
//  Created by Saim on 20/09/2023.
//

import UIKit

class OnboardingVC: UIViewController {
    static let storyboardIdentifier = "onboardingVC"
    
    let nameOfimagesToDisplay = ["first-image", "second-image", "third-image"]
    let titleMessages = ["Hand Delivered", "How It Works", "On-Demand Gifts"]
    let contentMessages = ["We'll take care of everything from wrapping to delivery", "Find the perfect gift and we will take care of the rest", "Choose from our curated selection of gifts for every occasion"]
    
    //    @IBOutlet var sliderView: UIView!
    @IBOutlet var imgCollectionView: UICollectionView!
    @IBOutlet var pageController: UIPageControl!
    
    override func viewWillAppear(_ animated: Bool) {
        navigationController?.navigationBar.backgroundColor = .clear
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        imgCollectionView.delegate = self
        imgCollectionView.dataSource = self
        imgCollectionView.showsHorizontalScrollIndicator = false
    }
    
    @IBAction func closeBtnTapped(_ sender: UIBarButtonItem) {
        imgCollectionView.removeFromSuperview()
        pageController.removeFromSuperview()
                
        sender.title = nil
        sender.image = nil
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        navigationItem.backButtonTitle = ""
        navigationController?.navigationBar.tintColor = .black
        navigationController?.navigationBar.backgroundColor = UIColor(red: 249/255, green: 224/255, blue: 30/255, alpha: 1.0)
    }
    
    
    @IBAction func registerBtnTapped(_ sender: Any) {
        performSegue(withIdentifier: "registerSegue", sender: nil)
    }
    
    @IBAction func signInBtnTapped(_ sender: Any) {
        performSegue(withIdentifier: "loginSegue", sender: nil)
    }
    
}

extension OnboardingVC: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        nameOfimagesToDisplay.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "OnboardingCollectionViewCell", for: indexPath) as! OnboardingCollectionViewCell
        
        let image = UIImage(named: nameOfimagesToDisplay[indexPath.row])!
        let title = titleMessages[indexPath.row]
        let content = contentMessages[indexPath.row]
        
        cell.configure(img: image, title: title, content: content)
        
        return cell
    }
}


extension OnboardingVC: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        let indexOfItemToBeDisplayed = indexPath.row
        pageController.currentPage = indexOfItemToBeDisplayed
    }
}

extension OnboardingVC: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let mainViewWidth = view.frame.width
        let mainViewHeight = view.frame.height
        
        return CGSize(width: mainViewWidth, height: mainViewHeight)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        0
    }
}
