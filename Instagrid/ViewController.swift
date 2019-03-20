//
//  ViewController.swift
//  Instagrid
//
//  Created by Paul Leclerc on 18/03/2019.
//  Copyright © 2019 Paul Leclerc. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var imagesView: ImagesView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
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
    }
    
}

