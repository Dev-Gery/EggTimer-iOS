//
//  ViewController.swift
//  EggTimer
//
//  Created by Angela Yu on 08/07/2019.
//  Copyright © 2019 The App Brewery. All rights reserved.
//

import UIKit

class AspectFitButton: UIButton {
    override func layoutSubviews() {
        super.layoutSubviews()
        
        // Set the background image content mode to aspect fit
        if (currentBackgroundImage != nil) {
            let imageView = self.subviews.compactMap { $0 as? UIImageView }.first
            imageView?.contentMode = .scaleAspectFit
        }
    }
}

class ViewController: UIViewController {
    @IBOutlet weak var titleButton: UILabel!
    @IBOutlet weak var softEggButton: AspectFitButton!
    @IBOutlet weak var mediumEggButton: AspectFitButton!
    @IBOutlet weak var hardEggButton: AspectFitButton!
    @IBOutlet weak var eggProgressBar: UIProgressView!
    let eggTimerSec = ["soft": 3, "medium": 4, "hard": 7]
    var timer = Timer()
    @IBAction func eggButtonPress(_ sender: UIButton) {
        timer.invalidate()
        titleButton.text = sender.currentTitle
        let eggOpt = sender.currentTitle?.lowercased()
        let eggTime = Float(eggTimerSec[eggOpt ?? "unknown"] ?? 0)
//        var countdown = eggTime
        var progress : Float = 0.0
        timer = Timer(timeInterval: 1.0, repeats: true) { timer in
            if (progress < eggTime) {
//                print(countdown)
                self.eggProgressBar.progress = progress / eggTime
                progress += 1
//                countdown -= 1
            } else if (progress == eggTime) {
                self.eggProgressBar.progress = 1
                self.titleButton.text = "Done!"
                DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                    self.titleButton.text = "How do you like your eggs?"
                }
                timer.invalidate()
            } else {
                print("case progress > eggTime, can't be compared, or something else")
                timer.invalidate()
            }
        }
        RunLoop.main.add(timer, forMode: .common)
        timer.fire()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        softEggButton.setBackgroundImage(UIImage(named: "soft_egg"), for: .normal)
        mediumEggButton.setBackgroundImage(UIImage(named: "medium_egg"), for: .normal)
        hardEggButton.setBackgroundImage(UIImage(named: "hard_egg"), for: .normal)

    }
    

}


