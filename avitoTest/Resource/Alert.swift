//
//  Alert.swift
//  avitoTest
//
//  Created by Никита on 25.04.2021.
//

import UIKit

extension UIViewController {
    
    func alertButtonCliked(message: String)  {
        let alert = UIAlertController(title: "Выбранная услуга", message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "sure", style: .default, handler: nil))
        
        present(alert, animated: true, completion: nil)
    }
}
