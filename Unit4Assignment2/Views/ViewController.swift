//
//  ViewController.swift
//  Unit4Assignment2
//
//  Created by Kevin Natera on 10/9/19.
//  Copyright © 2019 Kevin Natera. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var weatherCollectionOutlet: UICollectionView!
    @IBOutlet weak var zipCodeTextFieldOutlet: UITextField!
    @IBOutlet weak var cityLabel: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let layout = weatherCollectionOutlet.collectionViewLayout as! UICollectionViewFlowLayout
              layout.scrollDirection = .horizontal
        zipCodeTextFieldOutlet.keyboardType = .numberPad
        zipCodeTextFieldOutlet.delegate = self
    }


}

extension ViewController : UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = weatherCollectionOutlet.dequeueReusableCell(withReuseIdentifier: "weather", for: indexPath)
        return cell
    }
    
    
}

extension ViewController : UITextFieldDelegate {
    
    func textFieldDidChangeSelection(_ textField: UITextField) {
        if textField.text?.count == 5 {
            textField.resignFirstResponder()
            
        }
        
    }
}

