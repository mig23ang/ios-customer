//
//  FactoryLoader.swift
//  Customer-centric
//
//  Created by Slehyder Martinez on 28/11/23.
//

import Foundation
import UIKit

struct FactoryLoader {
    
    static func createCustomLoader(inView view: UIView, text: String = Constants.Strings.Loader.loading, backgroundColor: UIColor = UIColor(named: "primaryGreen")!) {
        
        if view.viewWithTag(101) != nil {
            debugPrint("Custom loader already added")
            return
        }
        
        let loaderView = UIView(frame: view.bounds)
        loaderView.backgroundColor = backgroundColor
        loaderView.tag = 101
        
        // view container circle
        let rotatingCircleView = UIView()
        rotatingCircleView.translatesAutoresizingMaskIntoConstraints = false
        rotatingCircleView.backgroundColor = .clear
        
        // layer circle
        let circleLayer = CAShapeLayer()
        circleLayer.strokeColor = UIColor(named: "yellowSpinner")!.cgColor
        circleLayer.fillColor = UIColor.clear.cgColor
        circleLayer.lineWidth = 10
        circleLayer.lineCap = .butt
        
        // label message loader
        let loadingLabel = UILabel()
        loadingLabel.text = text
        loadingLabel.textColor = UIColor.white
        loadingLabel.textAlignment = .center
        loadingLabel.translatesAutoresizingMaskIntoConstraints = false
        
        DispatchQueue.main.async {
            loaderView.addSubview(rotatingCircleView)
            loaderView.addSubview(loadingLabel)
            view.addSubview(loaderView)
            
            rotatingCircleView.layer.addSublayer(circleLayer)
            
            NSLayoutConstraint.activate([
                rotatingCircleView.centerXAnchor.constraint(equalTo: loaderView.centerXAnchor),
                rotatingCircleView.centerYAnchor.constraint(equalTo: loaderView.centerYAnchor),
                rotatingCircleView.widthAnchor.constraint(equalToConstant: 100),
                rotatingCircleView.heightAnchor.constraint(equalTo: rotatingCircleView.widthAnchor)
            ])
            
            NSLayoutConstraint.activate([
                loadingLabel.topAnchor.constraint(equalTo: rotatingCircleView.bottomAnchor, constant: 20),
                loadingLabel.centerXAnchor.constraint(equalTo: loaderView.centerXAnchor)
            ])
            
            // draw circle
            let circularPath = UIBezierPath(arcCenter: CGPoint(x: 0, y: 0),
                                            radius: 40,
                                            startAngle: 0,
                                            endAngle: .pi * 1.8,
                                            clockwise: true)
            circleLayer.path = circularPath.cgPath
            circleLayer.position = CGPoint(x: 50, y: 50)
            
            // init rotation the circle
            startRotatingLayer(circleLayer: circleLayer)
        }
    }
    
    static func removeCustomLoader(fromView view: UIView) {
        DispatchQueue.main.async {
            if let loaderView = view.viewWithTag(101) {
                loaderView.removeFromSuperview()
            }
        }
    }
    
    private static func startRotatingLayer(circleLayer: CAShapeLayer) {
        let rotationAnimation = CABasicAnimation(keyPath: "transform.rotation.z")
        rotationAnimation.toValue = NSNumber(value: Double.pi * 2)
        rotationAnimation.duration = 1
        rotationAnimation.isCumulative = true
        rotationAnimation.repeatCount = Float.infinity
        circleLayer.add(rotationAnimation, forKey: "rotationAnimation")
    }
}
