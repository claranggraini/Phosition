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
    }
}

