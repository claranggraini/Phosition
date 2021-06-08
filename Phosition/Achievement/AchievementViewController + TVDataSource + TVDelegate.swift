//
//  AchievementViewController + TVDataSource + TVDelegate.swift
//  Phosition
//
//  Created by Clara Anggraini on 08/06/21.
//

import UIKit

extension AchievementController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return achievements.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = achievementView.achievementCV.dequeueReusableCell(withReuseIdentifier: "AchievementCell", for: indexPath) as! AchievementCell
        
        if achievements[indexPath.row].isUnlocked{
            guard let achImageUnwrapped = achievements[indexPath.row].image else{return cell}
            cell.achievementIV.image = UIImage(named: achImageUnwrapped)
        }else{
            cell.achievementIV.backgroundColor = UIColor.gray
        }
        
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.bounds.width/3.5, height: 80)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 20, left: 2, bottom: 0, right: 2)
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        performSegue(withIdentifier: "achDetailSegue", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "achDetailSegue" {
            let dest = segue.destination as! DetailAchievementController
            let indexpath = self.achievementView.achievementCV.indexPathsForSelectedItems
            guard let indexUnwrapped = indexpath else{
                return
            }
            
            dest.selectedAch = achievements[indexUnwrapped[0].row]
            
        }
    }
}
