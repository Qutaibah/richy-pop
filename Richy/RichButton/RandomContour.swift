//
//  RandomContour.swift
//  Richy
//
//  Created by Qutaibah Essa on 16/04/2020.
//  Copyright © 2020 Richy. All rights reserved.
//

import UIKit

class RandomContourView: UIView {
    
    init(frame: CGRect, color: UIColor) {
        super.init(frame: frame)
        backgroundColor = .clear
        layer.addSublayer(randomContourShapeLayer(in: frame, using: color))
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func randomContourShapeLayer(in rect: CGRect, using color: UIColor) -> CAShapeLayer {
        let path = UIBezierPath()
        let radius = min(rect.maxX, rect.maxY)
        let randomMax = radius/5
        
        path.move(to: CGPoint(x: rect.maxX, y: rect.midY))
        path.addQuadCurve(to: CGPoint(x: rect.midX, y: 0),
                          controlPoint: CGPoint(x: rect.maxX-CGFloat.random(in: -randomMax...randomMax),
                                                y: CGFloat.random(in: -randomMax...randomMax)))
        path.addQuadCurve(to: CGPoint(x: 0, y: rect.midY),
                          controlPoint: CGPoint(x: CGFloat.random(in: -randomMax...randomMax),
                                                y: CGFloat.random(in: -randomMax...randomMax)))
        path.addQuadCurve(to: CGPoint(x: rect.midX, y: rect.maxY),
                          controlPoint: CGPoint(x: CGFloat.random(in: -randomMax...randomMax),
                                                y: rect.maxY + CGFloat.random(in: -randomMax...randomMax)))
        path.addQuadCurve(to: CGPoint(x: rect.maxX, y: rect.midY),
                          controlPoint: CGPoint(x: rect.maxX-CGFloat.random(in: -randomMax...randomMax),
                                                y: rect.maxY+CGFloat.random(in: -randomMax...randomMax)))
        
        path.lineCapStyle = .round
        path.lineJoinStyle = .round
        path.close()
        
        let layer = CAShapeLayer()
        layer.path = path.cgPath
        layer.fillColor = color.cgColor
        return layer
    }
}

