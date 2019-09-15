//
//  ViewController.swift
//  HomeWork_19
//
//  Created by MAC OS  on 12.09.2019.
//  Copyright © 2019 MAC OS . All rights reserved.
//

import UIKit

class ViewController: UIViewController {
  
  var viewGeenLeft = UIView()
  var viewGreenRight = UIView()
  var viewInteractive = UIView()
  
  var beginCoordinate = CGPoint.zero
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    createTwoGreenView()
    createInteractiveView()
    
    view.addGestureRecognizer(UIPanGestureRecognizer(target: self, action: #selector(handlePan)))
    
    let panGestureRecognizer = UIPanGestureRecognizer(target: self, action: #selector(dragTheView))
    viewInteractive.addGestureRecognizer(panGestureRecognizer)
    
  }
  
  func createTwoGreenView() {
    
    viewGeenLeft = UIView(frame: CGRect(x: 40, y: 60, width: 100, height: 100))
    viewGeenLeft.backgroundColor = .green
    view.addSubview(viewGeenLeft)
    
    viewGreenRight = UIView(frame: CGRect(x: 230, y: 60, width: 100, height: 100))
    viewGreenRight.backgroundColor = .green
    view.addSubview(viewGreenRight)
  }
  
  func createInteractiveView() {
    viewInteractive = UIView(frame: CGRect(x: 40, y: 60, width: 80, height: 80))
    viewInteractive.backgroundColor = .blue
    viewInteractive.center = viewGeenLeft.center
    view.addSubview(viewInteractive)
  }
  
  @objc func handlePan(gesture: UIPanGestureRecognizer) {
    let location = gesture.location(in: view)
    print(location)
  }
  
  @objc func dragTheView(recognizer: UIPanGestureRecognizer) {
    
    if recognizer.state == .began {
      beginCoordinate = viewInteractive.frame.origin
      print("Gesture began")
      
    } else if recognizer.state == .changed {
      
      let translation = recognizer.translation(in: self.view)
      
      let newX = viewInteractive.center.x + translation.x
      let newY = viewInteractive.center.y + translation.y
      
      viewInteractive.center = CGPoint(x: newX, y: newY)
      recognizer.setTranslation(CGPoint.zero, in: self.view)
      
    } else if recognizer.state == .ended {
      print("Gesture ended")
      
      if viewGeenLeft.frame.contains(viewInteractive.frame) {
        viewGeenLeft.center = viewInteractive.center
        print("вью 1 содержит вью 3")
        
      } else if viewGreenRight.frame.contains(viewInteractive.frame) {
        viewGreenRight.center = viewInteractive.center
        print("вью 2 содержит вью 3")
        
      } else {
        viewInteractive.frame.origin = beginCoordinate
        print("вью 3 вернулась в исходное положение")
      }
    }
  }
}

