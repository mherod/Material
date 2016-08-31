/*
* Copyright (C) 2015 - 2016, Daniel Dahan and CosmicMind, Inc. <http://cosmicmind.io>.
* All rights reserved.
*
* Redistribution and use in source and binary forms, with or without
* modification, are permitted provided that the following conditions are met:
*
*	*	Redistributions of source code must retain the above copyright notice, this
*		list of conditions and the following disclaimer.
*
*	*	Redistributions in binary form must reproduce the above copyright notice,
*		this list of conditions and the following disclaimer in the documentation
*		and/or other materials provided with the distribution.
*
*	*	Neither the name of Material nor the names of its
*		contributors may be used to endorse or promote products derived from
*		this software without specific prior written permission.
*
* THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS"
* AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE
* IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE
* DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT HOLDER OR CONTRIBUTORS BE LIABLE
* FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL
* DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR
* SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER
* CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY,
* OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE
* OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
*/

import UIKit
fileprivate func < <T : Comparable>(lhs: T?, rhs: T?) -> Bool {
  switch (lhs, rhs) {
  case let (l?, r?):
    return l < r
  case (nil, _?):
    return true
  default:
    return false
  }
}


open class ImageCardView : MaterialPulseView {
	/**
	:name:	dividerLayer
	*/
	fileprivate var dividerLayer: CAShapeLayer?
	
	/**
	:name:	dividerColor
	*/
	@IBInspectable open var dividerColor: UIColor? {
		didSet {
			dividerLayer?.backgroundColor = dividerColor?.cgColor
		}
	}
	
	/**
	:name:	divider
	*/
	@IBInspectable open var divider: Bool = true {
		didSet {
			reloadView()
		}
	}
	
	/**
	:name:	dividerInsets
	*/
	open var dividerInsetPreset: MaterialEdgeInset = .none {
		didSet {
			dividerInset = MaterialEdgeInsetToValue(dividerInsetPreset)
		}
	}
	
	/**
	:name:	dividerInset
	*/
	@IBInspectable open var dividerInset: UIEdgeInsets = UIEdgeInsets(top: 8, left: 0, bottom: 8, right: 0) {
		didSet {
			reloadView()
		}
	}
	
	/**
	:name:	imageLayer
	*/
	open fileprivate(set) var imageLayer: CAShapeLayer?
	
	/**
	:name:	image
	*/
	@IBInspectable open override var image: UIImage? {
		get {
			return nil == imageLayer?.contents ? nil : UIImage(cgImage: imageLayer?.contents as! CGImage)
		}
		set(value) {
			if let v = value {
				prepareImageLayer()
				imageLayer?.contents = v.cgImage
				if 0 == maxImageHeight {
					imageLayer?.frame.size.height = image!.size.height / contentsScale
				} else {
					let h: CGFloat = image!.size.height / contentsScale
					imageLayer?.frame.size.height = maxImageHeight < h ? maxImageHeight : h
				}
				imageLayer?.isHidden = false
			} else {
				imageLayer?.contents = nil
				imageLayer?.frame = CGRect.zero
				imageLayer?.isHidden = true
				imageLayer?.removeFromSuperlayer()
			}
			reloadView()
		}
	}
	
	/**
	:name:	maxImageHeight
	*/
	@IBInspectable open var maxImageHeight: CGFloat = 0 {
		didSet {
			if let v: UIImage = image {
				if 0 < maxImageHeight {
					prepareImageLayer()
					let h: CGFloat = v.size.height / contentsScale
					imageLayer?.frame.size.height = maxImageHeight < h ? maxImageHeight : h
				} else {
					maxImageHeight = 0
					imageLayer?.frame.size.height = nil == image ? 0 : v.size.height / contentsScale
				}
				reloadView()
			}
		}
	}
	
	/**
	:name:	contentsRect
	*/
	@IBInspectable open override var contentsRect: CGRect {
		didSet {
			prepareImageLayer()
			imageLayer?.contentsRect = contentsRect
		}
	}
	
	/**
	:name:	contentsCenter
	*/
	@IBInspectable open override var contentsCenter: CGRect {
		didSet {
			prepareImageLayer()
			imageLayer?.contentsCenter = contentsCenter
		}
	}
	
	/**
	:name:	contentsScale
	*/
	@IBInspectable open override var contentsScale: CGFloat {
		didSet {
			prepareImageLayer()
			imageLayer?.contentsScale = contentsScale
		}
	}
	
	/// Determines how content should be aligned within the visualLayer's bounds.
	@IBInspectable open override var contentsGravity: String {
		get {
			return nil == imageLayer ? "" : imageLayer!.contentsGravity
		}
		set(value) {
			prepareImageLayer()
			imageLayer?.contentsGravity = value
		}
	}
	
	/**
	:name:	contentInsets
	*/
	open var contentInsetPreset: MaterialEdgeInset = .square2 {
		didSet {
			contentInset = MaterialEdgeInsetToValue(contentInsetPreset)
		}
	}
	
	/**
	:name:	contentInset
	*/
	@IBInspectable open var contentInset: UIEdgeInsets = MaterialEdgeInsetToValue(.square2) {
		didSet {
			reloadView()
		}
	}
	
	/**
	:name:	titleLabelInsets
	*/
	open var titleLabelInsetPreset: MaterialEdgeInset = .square2 {
		didSet {
			titleLabelInset = MaterialEdgeInsetToValue(titleLabelInsetPreset)
		}
	}
	
	/**
	:name:	titleLabelInset
	*/
	@IBInspectable open var titleLabelInset: UIEdgeInsets = MaterialEdgeInsetToValue(.square2) {
		didSet {
			reloadView()
		}
	}
	
	/**
	:name:	titleLabel
	*/
	@IBInspectable open var titleLabel: UILabel? {
		didSet {
			reloadView()
		}
	}
	
	/**
	:name:	contentViewInsets
	*/
	open var contentViewInsetPreset: MaterialEdgeInset = .square2 {
		didSet {
			contentViewInset = MaterialEdgeInsetToValue(contentViewInsetPreset)
		}
	}
	
	/**
	:name:	contentViewInset
	*/
	@IBInspectable open var contentViewInset: UIEdgeInsets = MaterialEdgeInsetToValue(.square2) {
		didSet {
			reloadView()
		}
	}
	
	/**
	:name:	contentView
	*/
	@IBInspectable open var contentView: UIView? {
		didSet {
			reloadView()
		}
	}
	
	/**
	:name:	leftButtonsInsets
	*/
	open var leftButtonsInsetPreset: MaterialEdgeInset = .none {
		didSet {
			leftButtonsInset = MaterialEdgeInsetToValue(leftButtonsInsetPreset)
		}
	}
	
	/**
	:name:	leftButtonsInset
	*/
	@IBInspectable open var leftButtonsInset: UIEdgeInsets = MaterialEdgeInsetToValue(.none) {
		didSet {
			reloadView()
		}
	}
	
	/**
	:name:	leftButtons
	*/
	open var leftButtons: Array<UIButton>? {
		didSet {
			reloadView()
		}
	}
	
	/**
	:name:	rightButtonsInsets
	*/
	open var rightButtonsInsetPreset: MaterialEdgeInset = .none {
		didSet {
			rightButtonsInset = MaterialEdgeInsetToValue(rightButtonsInsetPreset)
		}
	}
	
	/**
	:name:	rightButtonsInset
	*/
	@IBInspectable open var rightButtonsInset: UIEdgeInsets = MaterialEdgeInsetToValue(.none) {
		didSet {
			reloadView()
		}
	}
	
	/**
	:name:	rightButtons
	*/
	open var rightButtons: Array<UIButton>? {
		didSet {
			reloadView()
		}
	}
	
	/**
	:name:	init
	*/
	public required init?(coder aDecoder: NSCoder) {
		super.init(coder: aDecoder)
	}
	
	/**
	:name:	init
	*/
	public override init(frame: CGRect) {
		super.init(frame: frame)
	}
	
	/**
	:name:	init
	*/
	public convenience init() {
		self.init(frame: CGRect.zero)
	}
	
	/**
	:name:	init
	*/
	public convenience init?(image: UIImage? = nil, titleLabel: UILabel? = nil, contentView: UIView? = nil, leftButtons: Array<UIButton>? = nil, rightButtons: Array<UIButton>? = nil) {
		self.init(frame: CGRect.zero)
		prepareProperties(image, titleLabel: titleLabel, contentView: contentView, leftButtons: leftButtons, rightButtons: rightButtons)
	}
	
	/**
	:name:	layoutSublayersOfLayer
	*/
	open override func layoutSublayers(of layer: CALayer) {
		super.layoutSublayers(of: layer)
		if self.layer == layer {
			// image
			imageLayer?.frame.size.width = bounds.width
			
			// divider
			if divider {
				var y: CGFloat = contentInset.bottom + dividerInset.bottom
				if 0 < leftButtons?.count {
					y += leftButtonsInset.top + leftButtonsInset.bottom + leftButtons![0].frame.height
				} else if 0 < rightButtons?.count {
					y += rightButtonsInset.top + rightButtonsInset.bottom + rightButtons![0].frame.height
				}
				if 0 < y {
					prepareDivider(bounds.height - y - 0.5, width: bounds.width)
				}
			} else {
				dividerLayer?.removeFromSuperlayer()
				dividerLayer = nil
			}
		}
	}
	
	/**
	:name:	reloadView
	*/
	open func reloadView() {
		// clear constraints so new ones do not conflict
		removeConstraints(constraints)
		for v in subviews {
			v.removeFromSuperview()
		}
		
		var verticalFormat: String = "V:|"
		var views: Dictionary<String, AnyObject> = Dictionary<String, AnyObject>()
		var metrics: Dictionary<String, AnyObject> = Dictionary<String, AnyObject>()
		
		if nil != imageLayer?.contents {
			verticalFormat += "-(insetTop)"
			metrics["insetTop"] = imageLayer!.frame.height
		} else if nil != titleLabel {
			verticalFormat += "-(insetTop)"
			metrics["insetTop"] = contentInset.top + titleLabelInset.top
		} else if nil != contentView {
			verticalFormat += "-(insetTop)"
			metrics["insetTop"] = contentInset.top + contentViewInset.top
		}
		
		// title
		if let v: UILabel = titleLabel {
			if nil == imageLayer?.contents {
				verticalFormat += "-[titleLabel]"
				views["titleLabel"] = v
			} else {
				layout(v).top(contentInset.top + titleLabelInset.top)
			}
			layout(v).horizontally(left: contentInset.left + titleLabelInset.left, right: contentInset.right + titleLabelInset.right)
		}
		
		// detail
		if let v: UIView = contentView {
			if nil == imageLayer?.contents && nil != titleLabel {
				verticalFormat += "-(insetB)"
				metrics["insetB"] = titleLabelInset.bottom + contentViewInset.top
			} else {
				metrics["insetTop"] = (metrics["insetTop"] as! CGFloat) + contentViewInset.top
			}
			
			verticalFormat += "-[contentView]"
			views["contentView"] = v
			
			layout(v).horizontally(left: contentInset.left + contentViewInset.left, right: contentInset.right + contentViewInset.right)
		}
		
		// leftButtons
		if let v: Array<UIButton> = leftButtons {
			if 0 < v.count {
				var h: String = "H:|"
				var d: Dictionary<String, AnyObject> = Dictionary<String, AnyObject>()
				var i: Int = 0
				for b in v {
					let k: String = "b\(i)"
					
					d[k] = b
					
					if 0 == i {
						h += "-(left)-"
					} else {
						h += "-(left_right)-"
					}
					
					h += "[\(k)]"
					
					layout(b).bottom(contentInset.bottom + leftButtonsInset.bottom)
					
					i += 1
				}
				
				addConstraints(Layout.constraint(h, options: [], metrics: ["left" : contentInset.left + leftButtonsInset.left, "left_right" : leftButtonsInset.left + leftButtonsInset.right], views: d))
			}
		}
		
		// rightButtons
		if let v: Array<UIButton> = rightButtons {
			if 0 < v.count {
				var h: String = "H:"
				var d: Dictionary<String, AnyObject> = Dictionary<String, AnyObject>()
				var i: Int = v.count - 1
				
				for b in v {
					let k: String = "b\(i)"
					
					d[k] = b
					
					h += "[\(k)]"
					
					if 0 == i {
						h += "-(right)-"
					} else {
						h += "-(right_left)-"
					}
					
					layout(b).bottom(contentInset.bottom + rightButtonsInset.bottom)
					
					i -= 1
				}
				
				addConstraints(Layout.constraint(h + "|", options: [], metrics: ["right" : contentInset.right + rightButtonsInset.right, "right_left" : rightButtonsInset.right + rightButtonsInset.left], views: d))
			}
		}
		
		if nil == imageLayer?.contents {
			if 0 < leftButtons?.count {
				verticalFormat += "-(insetC)-[button]"
				views["button"] = leftButtons![0]
				metrics["insetC"] = leftButtonsInset.top
				metrics["insetBottom"] = contentInset.bottom + leftButtonsInset.bottom
			} else if 0 < rightButtons?.count {
				verticalFormat += "-(insetC)-[button]"
				views["button"] = rightButtons![0]
				metrics["insetC"] = rightButtonsInset.top
				metrics["insetBottom"] = contentInset.bottom + rightButtonsInset.bottom
			}
			
			if nil != contentView {
				if nil == metrics["insetC"] {
					metrics["insetBottom"] = contentInset.bottom + contentViewInset.bottom + (divider ? dividerInset.top + dividerInset.bottom : 0)
				} else {
					metrics["insetC"] = (metrics["insetC"] as! CGFloat) + contentViewInset.bottom + (divider ? dividerInset.top + dividerInset.bottom : 0)
				}
			} else if nil != titleLabel {
				if nil == metrics["insetC"] {
					metrics["insetBottom"] = contentInset.bottom + titleLabelInset.bottom + (divider ? dividerInset.top + dividerInset.bottom : 0)
				} else {
					metrics["insetC"] = (metrics["insetC"] as! CGFloat) + titleLabelInset.bottom + (divider ? dividerInset.top + dividerInset.bottom : 0)
				}
			} else if nil != metrics["insetC"] {
				metrics["insetC"] = (metrics["insetC"] as! CGFloat) + contentInset.top + (divider ? dividerInset.top + dividerInset.bottom : 0)
			}
		} else if nil != contentView {
			if 0 < leftButtons?.count {
				verticalFormat += "-(insetC)-[button]"
				views["button"] = leftButtons![0]
				metrics["insetC"] = leftButtonsInset.top
				metrics["insetBottom"] = contentInset.bottom + leftButtonsInset.bottom
			} else if 0 < rightButtons?.count {
				verticalFormat += "-(insetC)-[button]"
				views["button"] = rightButtons![0]
				metrics["insetC"] = rightButtonsInset.top
				metrics["insetBottom"] = contentInset.bottom + rightButtonsInset.bottom
			}
			
			if nil == metrics["insetC"] {
				metrics["insetBottom"] = contentInset.bottom + contentViewInset.bottom + (divider ? dividerInset.top + dividerInset.bottom : 0)
			} else {
				metrics["insetC"] = (metrics["insetC"] as! CGFloat) + contentViewInset.bottom + (divider ? dividerInset.top + dividerInset.bottom : 0)
			}
		} else {
			if 0 < leftButtons?.count {
				verticalFormat += "-[button]"
				views["button"] = leftButtons![0]
				metrics["insetTop"] = (metrics["insetTop"] as! CGFloat) + contentInset.top + leftButtonsInset.top + (divider ? dividerInset.top + dividerInset.bottom : 0)
				metrics["insetBottom"] = contentInset.bottom + leftButtonsInset.bottom
			} else if 0 < rightButtons?.count {
				verticalFormat += "-[button]"
				views["button"] = rightButtons![0]
				metrics["insetTop"] = (metrics["insetTop"] as! CGFloat) + contentInset.top + rightButtonsInset.top + (divider ? dividerInset.top + dividerInset.bottom : 0)
				metrics["insetBottom"] = contentInset.bottom + rightButtonsInset.bottom
			} else {
				if translatesAutoresizingMaskIntoConstraints {
					addConstraints(Layout.constraint("V:[view(height)]", options: [], metrics: ["height": imageLayer!.frame.height as AnyObject], views: ["view": self]))
				} else {
					height = imageLayer!.frame.height
				}
			}
		}
		
		if 0 < views.count {
			verticalFormat += "-(insetBottom)-|"
			addConstraints(Layout.constraint(verticalFormat, options: [], metrics: metrics, views: views))
		}
	}
	
	/**
	:name:	prepareView
	*/
	open override func prepareView() {
		super.prepareView()
		depth = .depth1
		dividerColor = MaterialColor.grey.lighten3
		cornerRadiusPreset = .radius1
	}
	
	/**
	:name:	prepareImageLayer
	*/
	internal func prepareImageLayer() {
		if nil == imageLayer {
			imageLayer = CAShapeLayer()
			imageLayer!.masksToBounds = true
			imageLayer!.zPosition = 0
			visualLayer.addSublayer(imageLayer!)
		}
	}
	
	/**
	:name:	prepareDivider
	*/
	internal func prepareDivider(_ y: CGFloat, width: CGFloat) {
		if nil == dividerLayer {
			dividerLayer = CAShapeLayer()
			dividerLayer!.zPosition = 0
			layer.addSublayer(dividerLayer!)
		}
		dividerLayer?.backgroundColor = dividerColor?.cgColor
		dividerLayer?.frame = CGRect(x: dividerInset.left, y: y, width: width - dividerInset.left - dividerInset.right, height: 1)
	}
	
	/**
	:name:	prepareProperties
	*/
	internal func prepareProperties(_ image: UIImage?, titleLabel: UILabel?, contentView: UIView?, leftButtons: Array<UIButton>?, rightButtons: Array<UIButton>?) {
		self.image = image
		self.titleLabel = titleLabel
		self.contentView = contentView
		self.leftButtons = leftButtons
		self.rightButtons = rightButtons
	}
}
