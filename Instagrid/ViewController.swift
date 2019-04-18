//
//  ViewController.swift
//  Instagrid
//
//  Created by Paul Leclerc on 18/03/2019.
//  Copyright © 2019 Paul Leclerc. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

//    initiating colors variables
    var currentBackgroundColor = 0
    let colors = [#colorLiteral(red: 0.06433343142, green: 0.4015628099, blue: 0.5964629054, alpha: 1), #colorLiteral(red: 0.1960784346, green: 0.3411764801, blue: 0.1019607857, alpha: 1), #colorLiteral(red: 0.9529411793, green: 0.6862745285, blue: 0.1333333403, alpha: 1), #colorLiteral(red: 0.9254902005, green: 0.2352941185, blue: 0.1019607857, alpha: 1), #colorLiteral(red: 0.8078431487, green: 0.02745098062, blue: 0.3333333433, alpha: 1), #colorLiteral(red: 0.3647058904, green: 0.06666667014, blue: 0.9686274529, alpha: 1), #colorLiteral(red: 0.1215686277, green: 0.01176470611, blue: 0.4235294163, alpha: 1), #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1), #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)]
    
//    connecting buttons and views
    @IBOutlet weak var imagesView: ImagesView!
    @IBOutlet weak var dispositionButton1: UIButton!
    @IBOutlet weak var dispositionButton2: UIButton!
    @IBOutlet weak var dispositionButton3: UIButton!
    @IBOutlet weak var swipeLabel: UILabel!
    @IBOutlet weak var swipeImage: UIImageView!
    @IBOutlet weak var swipeView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        initiating disposition
        changeDisposition(to: .portrait)
        
//        initiating gestures
        let panGestureRecognizer = UIPanGestureRecognizer(target: self, action: #selector(swipeImagesView(_:)))
        imagesView.addGestureRecognizer(panGestureRecognizer)
    }
    
//    creating event on swipe
    @objc func swipeImagesView(_ sender: UIPanGestureRecognizer) {
            switch sender.state {
            case .began, .changed:
//                transforming imagesView
                transformImagesViewWith(gesture: sender)
            case .ended, .cancelled:
                switch UIDevice.current.orientation {
//                    treating gestures with orientation
                case .portrait, .faceDown, .faceUp, .portraitUpsideDown:
                    if sender.translation(in: imagesView).y < -50 {
                        shareImage()
//                        changing colors
                    } else if sender.translation(in: imagesView).x > 50 {
                        switchColor(add: true)
                    } else if sender.translation(in: imagesView).x < -50 {
                        switchColor(add: false)
                    }
                default:
                    if sender.translation(in: imagesView).x < -50 {
                        shareImage()
                    } else if sender.translation(in: imagesView).y > 50 {
                        switchColor(add: false)
                    } else if sender.translation(in: imagesView).y < -50 {
                        switchColor(add: true)
                    }
                }
                
//                resetting view after swipe
                if sender.translation(in: imagesView).x >= -50 {
                    resetView()
                }
                
            default:
                break
            }
        
    }
    
//    this function increments or decrements currentBackgroundColor
    private func switchColor(add incrementColors: Bool) {
        if incrementColors {
            currentBackgroundColor += 1
            if currentBackgroundColor >= colors.count {
                currentBackgroundColor = 0
            }
            imagesView.backgroundColor = colors[currentBackgroundColor]
        } else {
            currentBackgroundColor -= 1
            if currentBackgroundColor < 0 {
                currentBackgroundColor = colors.count - 1
            }
            imagesView.backgroundColor = colors[currentBackgroundColor]
        }
    }
    
//    this function opens and supports the sharing menu for the image
    private func shareImage() {
        // image to share
        let image = imagesView.asImage()
        
        // set up activity view controller
        let imageToShare = [ image ]
        let activityViewController = UIActivityViewController(activityItems: imageToShare, applicationActivities: nil)
        activityViewController.popoverPresentationController?.sourceView = self.view // so that iPads won't crash
        activityViewController.completionWithItemsHandler = { (type,completed,items,error) in self.resetView() }
        
        // present the view controller
        self.present(activityViewController, animated: true, completion: nil)
    }
    
    private func resetView() {
        UIView.animate(withDuration: 0.5, animations: {
            let translationTransform = CGAffineTransform(translationX: 0, y: 0)
            self.imagesView.transform = translationTransform
        }, completion: { (finished: Bool) in
            self.swipeView.isHidden = false
        })
    }
    
//    this function transforms imagesView with gesture
    private func transformImagesViewWith(gesture: UIPanGestureRecognizer) {
        let translation = gesture.translation(in: imagesView)
        
        let translationTransform: CGAffineTransform
        var translationValue: CGFloat
        
        switch UIDevice.current.orientation{
        case .portrait, .faceUp, .faceDown, .portraitUpsideDown:
            if translation.y > 0 {
                translationValue = 0
            } else {
                translationValue = translation.y
            }
            translationTransform = CGAffineTransform(translationX: 0, y: translationValue)
        default:
            if translation.x > 0 {
                translationValue = 0
            } else {
                translationValue = translation.x
            }
            translationTransform = CGAffineTransform(translationX: translationValue, y: 0)
        }
        
//        hidding swipeView if translation is started
        if translationValue < 0 {
            swipeView.isHidden = true
        } else {
            swipeView.isHidden = false
        }
        
        imagesView.transform = translationTransform
    }
    
//    this function starts the picture importation with UIImagePickerController
    @objc func importPicture() {
        let picker = UIImagePickerController()
        picker.allowsEditing = true
        picker.delegate = self
        present(picker, animated: true)
    }
    
//    this function imports the selected picture to currentButton in imagesView
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        guard let image = info[.editedImage] as? UIImage else { return }
        
        dismiss(animated: true, completion: nil)
        
        imagesView.setImage(image)
    }

//    importing images in the tapped button
    
    @IBAction func didTapButton(_ sender: UIButton) {
        imagesView.selectedButton = sender
        importPicture()
    }
    /*@IBAction func didTapButton1(_ sender: Any) {
        imagesView.selectedButton = .button1
        importPicture()
    }
    @IBAction func didTapButton2(_ sender: Any) {
        imagesView.selectedButton = .button2
        importPicture()
    }
    @IBAction func didTapButton3(_ sender: Any) {
        imagesView.selectedButton = .button3
        importPicture()
    }
    @IBAction func didTapButton4(_ sender: Any) {
        imagesView.selectedButton = .button4
        importPicture()
    }
    @IBAction func didTapLargeButton1(_ sender: Any) {
        imagesView.selectedButton = .largeButton1
        importPicture()
    }
    @IBAction func didTapLargeButton2(_ sender: Any) {
        imagesView.selectedButton = .largeButton2
        importPicture()
    }
 */
    
//    changing disposition with buttons
    @IBAction func didTapUpsideDownButton() {
        changeDisposition(to: .upsideDown)
    }
    @IBAction func didTapPortraitButton() {
        changeDisposition(to: .portrait)
    }
    @IBAction func didTapFourButton() {
        changeDisposition(to: .four)
    }
    func changeDisposition(to disposition: ImagesView.Disposition) {
        imagesView.disposition = disposition
        switch disposition {
        case .upsideDown:
            dispositionButton1.setImage(#imageLiteral(resourceName: "Selected"), for: .normal)
            dispositionButton2.setImage(nil, for: .normal)
            dispositionButton3.setImage(nil, for: .normal)
        case .portrait:
            dispositionButton1.setImage(nil, for: .normal)
            dispositionButton2.setImage(#imageLiteral(resourceName: "Selected"), for: .normal)
            dispositionButton3.setImage(nil, for: .normal)
        case .four:
            dispositionButton1.setImage(nil, for: .normal)
            dispositionButton2.setImage(nil, for: .normal)
            dispositionButton3.setImage(#imageLiteral(resourceName: "Selected"), for: .normal)
        }
    }
    
//    changing imagesView contents with device orientation
    override func didRotate(from fromInterfaceOrientation: UIInterfaceOrientation) {
        switch UIDevice.current.orientation{
        case .portrait:
            swipeLabel.text = "Swipe up to share"
            swipeImage.image = #imageLiteral(resourceName: "swipeUp")
        default:
            swipeLabel.text = "Swipe left to share"
            swipeImage.image = #imageLiteral(resourceName: "swipeLeft")
        }
    }
    
}

