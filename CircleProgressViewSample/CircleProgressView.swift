//
//  CircleProgressView.swift
//  CircleProgressViewSample
//
//  Created by viewdidload soft on 2020/04/27.
//  Copyright © 2020 ViewDidLoad. All rights reserved.
//

import UIKit

@IBDesignable class CircleProgressView: UIView {
    // 원형 상태바
    @IBInspectable let backLayer: CAShapeLayer = CAShapeLayer()
    @IBInspectable let foreLayer: CAShapeLayer = CAShapeLayer()
    // 배경 두께
    @IBInspectable var backWidth: CGFloat {
        get {
            return backLayer.lineWidth
        }
        set {
            backLayer.lineWidth = newValue
        }
    }
    // 배경 색상
    @IBInspectable var backColor: UIColor {
        get {
            let cgColor = backLayer.strokeColor ?? UIColor.lightGray.cgColor
            return UIColor(cgColor: cgColor)
        }
        set {
            backLayer.strokeColor = newValue.cgColor
        }
    }
    // 상태 두께
    @IBInspectable var foreWidth: CGFloat {
        get {
            return foreLayer.lineWidth
        }
        set {
            foreLayer.lineWidth = newValue
        }
    }
    // 상태 색상
    @IBInspectable var foreColor: UIColor {
        get {
            let cgColor = foreLayer.strokeColor ?? UIColor.red.cgColor
            return UIColor(cgColor: cgColor)
        }
        set {
            foreLayer.strokeColor = newValue.cgColor
        }
    }
    // 진행 상태 값
    @IBInspectable var percent: CGFloat = 0

    var circle_center: CGPoint {
        return CGPoint(x: self.bounds.width / 2, y: self.bounds.height / 2)
    }
    var min_radius: CGFloat {
        return self.bounds.width < self.bounds.height ? self.bounds.width / 2 : self.bounds.height / 2
    }
    var circle_radius: CGFloat {
        return self.min_radius - (self.backWidth / 2)
    }
    var startAngle: CGFloat {
        return degreeToRadian(degree: 270)
    }
    
    override init(frame: CGRect) {
       super.init(frame: frame)
        initSetUp()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        initSetUp()
    }
    
    fileprivate func initSetUp() {
        print("initSetUp")
        // 원형 프로그레스 배경
        backLayer.fillColor = UIColor.clear.cgColor
        self.layer.addSublayer(backLayer)
        // 원형 프로그레스 색상
        foreLayer.fillColor = UIColor.clear.cgColor
        foreLayer.zPosition = backLayer.zPosition + 0.1
        self.layer.addSublayer(foreLayer)
    }
    
    override func draw(_ rect: CGRect) {
        print("CircleProgressView draw \(rect)")
        // 원형 프로그레스 바 백그라운드 프로그레스
        let circle_center = CGPoint(x: rect.width / 2, y: rect.height / 2)
        let min_radius = rect.width < rect.height ? rect.width / 2 : rect.height / 2
        let circle_radius: CGFloat = min_radius - (backWidth / 2)
        let circlePath = UIBezierPath(arcCenter: circle_center, radius: circle_radius, startAngle: 0, endAngle: 2 * .pi, clockwise: true)
        backLayer.path = circlePath.cgPath
        backLayer.strokeColor = backColor.cgColor
        // percent 프로그레스 표시
        progressUpdate(percent: percent)
    }
    // 외부에서 호출 가능
    func progressUpdate(percent: CGFloat) {
        let endDegree = percentToDegree(percent: percent)
        let endAngle: CGFloat = degreeToRadian(degree: endDegree)
        let profressCirclePath = UIBezierPath(arcCenter: circle_center, radius: circle_radius, startAngle: startAngle, endAngle: endAngle, clockwise: true)
        foreLayer.strokeColor = foreColor.cgColor
        foreLayer.path = profressCirclePath.cgPath
    }
    
    fileprivate func degreeToRadian(degree: CGFloat) -> CGFloat {
        return degree * (CGFloat.pi / 180)
    }

    fileprivate func percentToDegree(percent: CGFloat) -> CGFloat {
        // 0% - 270도, 25% - 360도 및 0도, 50% - 90도, 75% - 180도
        var degree: CGFloat = 0 //(360 / 100) * percent
        switch percent {
        case 0...25:
            degree = 270.0 + (3.6 * percent)
        case 26...99:
            degree = (3.6 * percent) - 90
        case 100:
            degree = 269.99999
        default:
            print("percentToDegree percent \(percent), degree \(degree)")
        }
        return degree
    }
}
