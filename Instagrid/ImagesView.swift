//
//  ImagesView.swift
//  Instagrid
//
//  Created by Paul Leclerc on 20/03/2019.
//  Copyright © 2019 Paul Leclerc. All rights reserved.
//

import UIKit

class ImagesView: UIView {

    enum Disposition {
        case portrait, upsideDown, four
    }
    
    @IBOutlet private var button1: UIButton!
    @IBOutlet private var button2: UIButton!
    @IBOutlet private var button3: UIButton!
    @IBOutlet private var button4: UIButton!
    @IBOutlet private var largeButton1: UIButton!
    @IBOutlet private var largeButton2: UIButton!
    
    var disposition: Disposition = .portrait {
        didSet {
            setDisposition(disposition)
        }
    }
    
    private func setDisposition(_ disposition: Disposition) {
        switch disposition {
        case .portrait:
            button1.isHidden = false
            button2.isHidden = false
            button3.isHidden = true
            button4.isHidden = true
            largeButton1.isHidden = true
            largeButton2.isHidden = false
        case .upsideDown:
            button1.isHidden = true
            button2.isHidden = true
            button3.isHidden = false
            button4.isHidden = false
            largeButton1.isHidden = false
            largeButton2.isHidden = true
        case .four:
            button1.isHidden = false
            button2.isHidden = false
            button3.isHidden = false
            button4.isHidden = false
            largeButton1.isHidden = true
            largeButton2.isHidden = true
        }
    }

}
