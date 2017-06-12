//
//  MapAnnotationView.swift
//  GoogleMapsTest
//
//  Created by kateryna.zaikina on 6/7/17.
//  Copyright © 2017 kateryna.zaikina. All rights reserved.
//

import UIKit
import MapKit
import SnapKit

class MapAnnotationView: MKAnnotationView {
    
    private var calloutView: InfoView!

    override init(annotation: MKAnnotation?, reuseIdentifier: String?) {
        super.init(annotation: annotation, reuseIdentifier: reuseIdentifier)
        
        setup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        setup()
    }
    
    private func setup() {
        image = UIImage(named: "iconMap")
        frame.size = CGSize(width: 40, height: 40)
        layer.anchorPoint = CGPoint(x: 0.5, y: 1.0)

        calloutView = InfoView.loadFromNib()
        calloutView.text = annotation?.title ?? ""
        canShowCallout = false
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        if selected {
            addSubview(calloutView)
            calloutView.snp.makeConstraints { make in
                make.centerX.equalTo(self)
                make.bottom.equalTo(self).offset(-self.frame.height)
            }
            calloutView.alpha = 0
            UIView.animate(withDuration: 0.2, animations: {
                self.calloutView.alpha = 1
            })
        } else {
            calloutView.removeFromSuperview()
        }
    }
    
}
