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
    
//    Connecting image buttons
    @IBOutlet public var button1: UIButton!
    @IBOutlet private var button2: UIButton!
    @IBOutlet private var button3: UIButton!
    @IBOutlet private var button4: UIButton!
    @IBOutlet private var largeButton1: UIButton!
    @IBOutlet private var largeButton2: UIButton!
    
    var selectedButton = UIButton()
    
    
//    When disposition is set, calling setDisposition()
    var disposition: Disposition = .portrait {
        didSet {
            setDisposition(disposition)
        }
    }
    
//    Set selected image to selectedButton
    func setImage(_ image:UIImage) {
        switch selectedButton {
        case button1:
            button1.setImage(image, for: .normal)
//            the 3 next lines are here to set the good image format. I can't set before because init images are in another format.
            button1.contentHorizontalAlignment = .fill
            button1.contentVerticalAlignment = .fill
            button1.imageView?.contentMode = .scaleAspectFill
        case button2:
            button2.setImage(image, for: .normal)
            button2.contentHorizontalAlignment = .fill
            button2.contentVerticalAlignment = .fill
            button2.imageView?.contentMode = .scaleAspectFill
        case button3:
            button3.setImage(image, for: .normal)
            button3.contentHorizontalAlignment = .fill
            button3.contentVerticalAlignment = .fill
            button3.imageView?.contentMode = .scaleAspectFill
        case button4:
            button4.setImage(image, for: .normal)
            button4.contentHorizontalAlignment = .fill
            button4.contentVerticalAlignment = .fill
            button4.imageView?.contentMode = .scaleAspectFill
        case largeButton1:
            largeButton1.setImage(image, for: .normal)
            largeButton1.contentHorizontalAlignment = .fill
            largeButton1.contentVerticalAlignment = .fill
            largeButton1.imageView?.contentMode = .scaleAspectFill
        case largeButton2:
            largeButton2.setImage(image, for: .normal)
            largeButton2.contentHorizontalAlignment = .fill
            largeButton2.contentVerticalAlignment = .fill
            largeButton2.imageView?.contentMode = .scaleAspectFill
        default:
            break
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
