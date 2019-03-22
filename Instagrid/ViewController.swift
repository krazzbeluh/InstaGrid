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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        changeDisposition(to: .portrait)
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
    }

    @IBAction func didTapButton1(_ sender: Any) {
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
    
}

