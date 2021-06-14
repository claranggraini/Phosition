//
//  ViewController.swift
//  Phosition
//
//  Created by Clara Anggraini on 05/06/21.
//

import UIKit
import CoreData

class CompositionController: UIViewController {
    
    @IBOutlet weak var collectionView: UICollectionView!
    let compCollectionViewCellId = "CompCollectionViewCell"
    
    lazy var compositions = Database.shared.getCompositions()
    
    override func viewDidLoad() {
        super.viewDidLoad()
                
        if #available(iOS 13.0, *) {
            let navBarAppearance = UINavigationBarAppearance()
            navBarAppearance.configureWithOpaqueBackground()
            navBarAppearance.largeTitleTextAttributes = [.foregroundColor: UIColor(named: "Cream")!, .font: UIFont(name: "Raleway Thin Bold", size: 34)!]
            navBarAppearance.largeTitleTextAttributes = [.foregroundColor: UIColor.white]
            navBarAppearance.backgroundColor = UIColor(named: "Blue")
            self.navigationController!.navigationBar.standardAppearance = navBarAppearance
            self.navigationController!.navigationBar.scrollEdgeAppearance = navBarAppearance
        }
        
        //register cell
        let nibCell = UINib(nibName: compCollectionViewCellId, bundle: nil)
        collectionView.register(nibCell, forCellWithReuseIdentifier: compCollectionViewCellId)
        
    }
}

extension CompositionController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return compositions.count
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        let inset:CGFloat = 10
        return UIEdgeInsets(top: inset, left: inset, bottom: inset, right: inset)
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: compCollectionViewCellId, for: indexPath) as! CompCollectionViewCell
        guard var unwrapImage = compositions[indexPath.row].image else {return cell}
        guard var unwrapTitle = compositions[indexPath.row].title else {return cell}
        guard var unwrapSubs = compositions[indexPath.row].subtitle else {return cell}
        
        let image  = unwrapImage
        let title = unwrapTitle
        let subs = unwrapSubs
        
        return cell
    }
    
}

