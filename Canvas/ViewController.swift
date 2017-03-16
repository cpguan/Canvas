//
//  ViewController.swift
//  Canvas
//
//  Created by Pan Guan on 3/16/17.
//  Copyright © 2017 Pan Guan. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var trayView: UIView!
    @IBOutlet weak var trayArray: UIImageView!
   
    var trayCenterWhenOpen: CGPoint!
    var trayCenterWhenClosed: CGPoint!
    var trayOriginalCenter: CGPoint!
    
    var newCreatedFace: UIImageView!
    var faceOriginalCenter: CGPoint!

    override func viewDidLoad() {
        super.viewDidLoad()
        trayCenterWhenOpen = trayView.center
        trayCenterWhenClosed = CGPoint(x: trayView.center.x, y: trayView.center.y + 250)
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func onTrayPanGesture(_ sender: UIPanGestureRecognizer) {
 //       let location = sender.location(in: view)
 //       let translation = sender.translation(in: view)
        let velocity = sender.velocity(in: view)
        
        if sender.state == .began {
            trayOriginalCenter = trayView.center
        } else if sender.state == .changed {
            //trayView.center = CGPoint(x: trayOriginalCenter.x, y: trayOriginalCenter.y + translation.y)
            if velocity.y > 0 {
                UIView.animate(withDuration: 0.3, animations: {
                    self.trayView.center = self.trayCenterWhenClosed
                })
                self.trayArray.transform = CGAffineTransform(rotationAngle:CGFloat(180 * M_PI / 180))
            }
            if velocity.y < 0 {
                UIView.animate(withDuration: 0.3, animations: {
                    self.trayView.center = self.trayCenterWhenOpen
                    
                })
                self.trayArray.transform = CGAffineTransform(rotationAngle:CGFloat(0 * M_PI / 180))
            }
        } else if sender.state == .ended {
            print("Ended")
        }
    }
    
    @IBAction func onFaceGesture(_ sender: UIPanGestureRecognizer) {
        //let location = sender.location(in: view)
        let translation = sender.translation(in: view)
        //let velocity = sender.velocity(in: view)
        
        if sender.state == .began {
            let imageView = sender.view as? UIImageView
            self.newCreatedFace = UIImageView(image: imageView?.image)
            self.view.addSubview(self.newCreatedFace)
            self.newCreatedFace.center = (imageView?.center)!
            
            self.newCreatedFace.transform = CGAffineTransform(scaleX: 2, y: 2)
            
            let faceCenter = self.newCreatedFace.center
            self.newCreatedFace.center = CGPoint(x: faceCenter.x, y: faceCenter.y + trayView.frame.origin.y)
            faceOriginalCenter = newCreatedFace.center
            
        } else if sender.state == .changed {
            newCreatedFace.center = CGPoint(x: faceOriginalCenter.x + translation.x, y: faceOriginalCenter.y + translation.y)
            
        } else if sender.state == .ended {
            newCreatedFace.transform =
                CGAffineTransform(scaleX: 1.5, y: 1.5)
            
        }
    }
    
    @IBAction func onFacePinch(_ sender: UIPinchGestureRecognizer) {
        //var scale = sender.scale
        //var velocity = sender.velocity

        }
    

}

