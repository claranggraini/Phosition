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
    var selectedCellIndexPath: IndexPath?
    lazy var compositions = Database.shared.getCompositions()
    let navBarAppearance = UINavigationBarAppearance()
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if #available(iOS 13.0, *) {
           
            navBarAppearance.configureWithOpaqueBackground()
            navBarAppearance.largeTitleTextAttributes = [.foregroundColor: UIColor(named: "Cream")!, .font: UIFont(name: "Raleway Thin Bold", size: 34)!]
            navBarAppearance.largeTitleTextAttributes = [.foregroundColor: UIColor.white]
        }
        
        //register cell
        let nibCell = UINib(nibName: compCollectionViewCellId, bundle: nil)
        collectionView.register(nibCell, forCellWithReuseIdentifier: compCollectionViewCellId)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.navigationController?.navigationBar.isTranslucent = false
        navBarAppearance.backgroundColor = UIColor(named: "Blue")
        navBarAppearance.backgroundImage = UIImage(named: "backpattern")
        self.navigationController!.navigationBar.standardAppearance = navBarAppearance
        self.navigationController!.navigationBar.scrollEdgeAppearance = navBarAppearance
        
        self.navigationController?.navigationBar.prefersLargeTitles = true
        self.navigationController?.navigationBar.sizeToFit()
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "detailCompSegue"{
            let dest = segue.destination as! DetailCompositionController
            dest.selectedComposition = compositions[selectedCellIndexPath!.row].title
            navBarAppearance.backgroundImage = nil
            navBarAppearance.backgroundColor = .clear
            self.navigationController!.navigationBar.standardAppearance = navBarAppearance
            self.navigationController!.navigationBar.scrollEdgeAppearance = navBarAppearance
        }
    }
}

extension CompositionController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return compositions.count
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return centerItemsInCollectionView(cellWidth: 325, numberOfItems: 1.1, spaceBetweenCell: 24, collectionView: collectionView)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 325, height: 447)
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: compCollectionViewCellId, for: indexPath) as! CompCollectionViewCell
        guard let unwrapImage = compositions[indexPath.row].image else {return cell}
        guard let unwrapTitle = compositions[indexPath.row].title else {return cell}
        guard let unwrapSubs = compositions[indexPath.row].subtitle else {return cell}
        
        cell.compImage.image =  UIImage(named: unwrapImage)
        cell.compTitle.text = unwrapTitle
        cell.compDesc.text = unwrapSubs
        cell.startLesson = {
            self.selectedCellIndexPath = indexPath
            self.performSegue(withIdentifier: "detailCompSegue", sender: self)
        }
        cell.layer.masksToBounds = false
        cell.layer.shadowRadius = 3
        cell.layer.shadowOpacity = 0.4
        cell.layer.shadowColor = UIColor.black.cgColor
        cell.layer.shadowOffset = CGSize(width: 4, height: 4)
        return cell
    }
    
    func centerItemsInCollectionView(cellWidth: Double, numberOfItems: Double, spaceBetweenCell: Double, collectionView: UICollectionView) -> UIEdgeInsets {
        let totalWidth = cellWidth * numberOfItems
        let totalSpacingWidth = spaceBetweenCell * (numberOfItems - 1)
        let leftInset = (collectionView.frame.width - CGFloat(totalWidth + totalSpacingWidth)) / 2
        let rightInset = leftInset
        return UIEdgeInsets(top: 0, left: leftInset, bottom: 0, right: rightInset)
    }

}

