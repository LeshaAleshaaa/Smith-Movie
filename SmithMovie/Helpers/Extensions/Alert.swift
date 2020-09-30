//
//  Alert.swift
//  SmithMovie
//
//  Created by Алексей Смицкий on 29.09.2020.
//  Copyright © 2020 Смицкий А.Д. All rights reserved.
//

import UIKit

// MARK: - FilmListController Extension

extension FilmListController {
    
    // MARK: - Public methods
    
    func alert(title: String, message: String) {
        
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let donebutton = UIAlertAction(title: "OK", style: .cancel, handler: nil)
        
        alert.addAction(donebutton)
        
        present(alert, animated: true, completion: nil)
    }
}
