//
//  ViewController.swift
//  Instagrid
//
//  Created by Paul Leclerc on 18/03/2019.
//  Copyright © 2019 Paul Leclerc. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    var currentImage: UIImage!
    
    @IBOutlet weak var imagesView: ImagesView!
    @IBOutlet weak var dispositionButton1: UIButton!
    @IBOutlet weak var dispositionButton2: UIButton!
    @IBOutlet weak var dispositionButton3: UIButton!
    @IBOutlet weak var swipeLabel: UILabel!
    @IBOutlet weak var swipeImage: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        changeDisposition(to: .portrait)
        currentImage = #imageLiteral(resourceName: "Selected")
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    @objc func importPicture() {
        let picker = UIImagePickerController()
        picker.allowsEditing = true
        picker.delegate = self
        present(picker, animated: true)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        guard let image = info[.editedImage] as? UIImage else { return }
        
        dismiss(animated: true)
        
        currentImage = image
        imagesView.setImage(image)
    }

    @IBAction func didTapButton1(_ sender: Any) {
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

