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
    
    enum Buttons {
        case button1, button2, button3, button4, largeButton1, largeButton2
    }
    
//    Connecting image buttons
    @IBOutlet private var button1: UIButton!
    @IBOutlet private var button2: UIButton!
    @IBOutlet private var button3: UIButton!
    @IBOutlet private var button4: UIButton!
    @IBOutlet private var largeButton1: UIButton!
    @IBOutlet private var largeButton2: UIButton!
    
//    When disposition is set, calling setDisposition()
    var disposition: Disposition = .portrait {
        didSet {
            setDisposition(disposition)
        }
    }
    
    var selectedButton: Buttons = .button1
    
//    Set selected image to selectedButton
    func setImage(_ image:UIImage) {
        switch selectedButton {
        case .button1:
            button1.setImage(image, for: .normal)
        case .button2:
            button2.setImage(image, for: .normal)
        case .button3:
            button3.setImage(image, for: .normal)
        case .button4:
            button4.setImage(image, for: .normal)
        case .largeButton1:
            largeButton1.setImage(image, for: .normal)
        case .largeButton2:
            largeButton2.setImage(image, for: .normal)
        }
    }
    
//    transform imagesView to image
    func asImage() -> UIImage {
        let renderer = UIGraphicsImageRenderer(bounds: bounds)
        return renderer.image { rendererContext in
            layer.render(in: rendererContext.cgContext)
        }
    }
    
//    set the disposition properties
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
