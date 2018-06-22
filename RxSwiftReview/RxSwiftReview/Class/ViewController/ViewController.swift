//
//  ViewController.swift
//  RxSwiftReview
//
//  Created by neoby on 2018/6/21.
//  Copyright © 2018年 arther. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var ImageView: UIImageView!
    
    let screenWidth = UIScreen.main.bounds.width
    let screenHeight = UIScreen.main.bounds.height
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let panGR = UIPanGestureRecognizer(target: self, action: #selector(ViewController.imageViewMove(rec:)))
        ImageView.isUserInteractionEnabled = true
        ImageView.addGestureRecognizer(panGR)
        ImageView.backgroundColor = UIColor.white

    }
    
    @objc func imageViewMove(rec: UIPanGestureRecognizer) {
        let point = rec.translation(in: self.view)
        var moveMinX = (rec.view?.frame.minX)!
        var moveMinY = (rec.view?.frame.minY)!
        let moveMaxX = (rec.view?.frame.maxX)!
        let moveMaxY = (rec.view?.frame.maxY)!
        let imageSize = (rec.view?.frame.size)!
        
        
        
        if moveMaxX > screenWidth {
            moveMinX = screenWidth - imageSize.width
        } else if moveMinX < CGFloat(-1) {
            moveMinX = 0
        } else {
            moveMinX = (rec.view?.frame.minX)! + point.x
        }
        
        if moveMaxY > screenHeight {
            moveMinY = screenHeight - imageSize.height
        } else if moveMinY < CGFloat(-1) {
            moveMinY = 0
        } else {
            moveMinY = (rec.view?.frame.minY)! + point.y
        }
        
        rec.view?.frame.origin = CGPoint(x: moveMinX, y: moveMinY)
        rec.setTranslation(CGPoint.zero, in: self.view)
        
        if rec.state == .ended || rec.state == .cancelled {
            if (rec.view?.center.x)! < screenWidth / 2 {
                moveMinX = 0
            } else {
                moveMinX = screenWidth - imageSize.width
            }
            
            UIView.animate(withDuration: 0.25) {
                rec.view?.frame.origin = CGPoint(x: moveMinX, y: moveMinY)
                rec.setTranslation(CGPoint.zero, in: self.view)
            }
        }
    }
    
}

