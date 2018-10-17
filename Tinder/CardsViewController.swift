//
//  CardsViewController.swift
//  Tinder
//
//  Created by Jangey Lu on 10/16/18.
//  Copyright © 2018 Jangey Lu. All rights reserved.
//

import UIKit

class CardsViewController: UIViewController {
    
    //let navBarImage = UIImage(named: "nav_bar")
    
    @IBOutlet weak var navBarImage: UIImageView!
    @IBOutlet weak var cardPicture: UIImageView!
    
    // element for faces
    //var newlyCardPicture: UIImageView!
    var cardInitialCenter: CGPoint!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        //navigationBar.setBackgroundImage(navBarImage, for: .default)
        
    }

    @IBAction func didPanCard(_ sender: UIPanGestureRecognizer) {
        let translation = sender.translation(in: view)
        
        if sender.state == .began {
            //newlyCardPicture = sender.view as? UIImageView
            //cardInitialCenter = newlyCardPicture.center
            cardInitialCenter = cardPicture.center
            
        } else if sender.state == .changed {
            cardPicture.transform = view.transform.rotated(by:CGFloat(translation.x * CGFloat(Double.pi) / 180))
            
            cardPicture.center = CGPoint(x: cardInitialCenter.x + (translation.x), y: cardInitialCenter.y)
        } else if sender.state == .ended {
            cardPicture.center = cardInitialCenter
            //cardPicture.transform.rotated(by: cardinitalRotation)
        }
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
