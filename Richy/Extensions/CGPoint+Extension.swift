//
//  CGPoint+Extension.swift
//  Richy
//
//  Created by Qutaibah Essa on 16/04/2020.
//  Copyright © 2020 Richy. All rights reserved.
//

import UIKit

extension CGPoint {
    static func random(inside rect: CGRect) -> CGPoint {
        return CGPoint(x: CGFloat.random(in: rect.minX...rect.maxX),
                       y: CGFloat.random(in: rect.minY...rect.maxY))
    }
    
    /// SwifterSwift: Distance from another CGPoint.
    ///
    ///     let point1 = CGPoint(x: 10, y: 10)
    ///     let point2 = CGPoint(x: 30, y: 30)
    ///     let distance = point1.distance(from: point2)
    ///     //distance = 28.28
    ///
    /// - Parameter point: CGPoint to get distance from.
    /// - Returns: Distance between self and given CGPoint.
    public func distance(from point: CGPoint) -> CGFloat {
        return CGPoint.distance(from: self, to: point)
    }
    
    /// SwifterSwift: Distance between two CGPoints.
    ///
    ///     let point1 = CGPoint(x: 10, y: 10)
    ///     let point2 = CGPoint(x: 30, y: 30)
    ///     let distance = CGPoint.distance(from: point2, to: point1)
    ///     //Distance = 28.28
    ///
    /// - Parameters:
    ///   - point1: first CGPoint.
    ///   - point2: second CGPoint.
    /// - Returns: distance between the two given CGPoints.
    public static func distance(from point1: CGPoint, to point2: CGPoint) -> CGFloat {
        // http://stackoverflow.com/questions/6416101/calculate-the-distance-between-two-cgpoints
        return sqrt(pow(point2.x - point1.x, 2) + pow(point2.y - point1.y, 2))
    }
}
