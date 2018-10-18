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
    
    // element for card
    var cardInitialCenter: CGPoint!
    
    // inital points when swap cardPicture
    var startPointY: CGFloat!
    var startMidFrameHeight: CGFloat!
    
    // custom modal transition
    var fadeTransition: FadeTransition!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        //navigationBar.setBackgroundImage(navBarImage, for: .default)
        
    }

    @IBAction func didPanCard(_ sender: UIPanGestureRecognizer) {
        let translation = sender.translation(in: view)
        
        if sender.state == .began {
            cardInitialCenter = cardPicture.center
            startPointY = sender.location(in: cardPicture).y
            startMidFrameHeight = cardPicture.frame.height/2
        } else if sender.state == .changed {
            // check if startPoint on Upper frame or Lower frame
            if startPointY < startMidFrameHeight {
                // if startPoint on Upper frame rotate clockwise
                cardPicture.transform = view.transform.rotated(by:CGFloat(translation.x/10 * CGFloat(Double.pi) / 180))
                cardPicture.center = CGPoint(x: cardInitialCenter.x + (translation.x), y: cardInitialCenter.y)
            } else if startPointY > startMidFrameHeight {
                // if startPoint on lower frame rotate counterclockwise
                cardPicture.transform = view.transform.rotated(by:CGFloat(-translation.x/10 * CGFloat(Double.pi) / 180))
                cardPicture.center = CGPoint(x: cardInitialCenter.x + (translation.x), y: cardInitialCenter.y)
            }
        } else if sender.state == .ended {
            if abs(translation.x) > 50 {
                UIView.animate(withDuration: 0.3, animations: {
                    self.cardPicture.removeFromSuperview()
                })
            } else {
                cardPicture.center = cardInitialCenter
                cardPicture.transform = CGAffineTransform.identity
            }
        }
    }
    
    @IBAction func didTapCard(_ sender: UITapGestureRecognizer) {
        performSegue(withIdentifier: "ShowProfile", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        // Access the ViewController that you will be transitioning too, a.k.a, the destinationViewController.
        let destinationViewController = segue.destination
        
        // Set the modal presentation style of your destinationViewController to be custom.
        destinationViewController.modalPresentationStyle = UIModalPresentationStyle.custom
        
        // Create a new instance of your fadeTransition.
        fadeTransition = FadeTransition()
        
        // Tell the destinationViewController's  transitioning delegate to look in fadeTransition for transition instructions.
        destinationViewController.transitioningDelegate = fadeTransition
        
        // Adjust the transition duration. (seconds)
        fadeTransition.duration = 1.0
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
