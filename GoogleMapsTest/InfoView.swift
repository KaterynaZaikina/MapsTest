//
//  InfoView.swift
//  GoogleMapsTest
//
//  Created by kateryna.zaikina on 6/6/17.
//  Copyright © 2017 kateryna.zaikina. All rights reserved.
//

import UIKit

class InfoView: UIView {

    @IBOutlet private var infoLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        layer.cornerRadius = 3
        translatesAutoresizingMaskIntoConstraints = false
    }
    
    static func loadFromNib() -> InfoView {
        let nib = UINib(nibName: String(describing: self), bundle: Bundle(for: self))
        guard let view = nib.instantiate(withOwner: nil, options: nil).first as? InfoView else {
            fatalError("The nib \(nib) expected its root view to be of type \(self)")
        }
        
        return view
    }
    
    var text: String? {
        didSet {
            infoLabel.text = text
        }
    }

}
