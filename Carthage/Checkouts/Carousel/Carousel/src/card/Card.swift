import UIKit
import Spatial

open class Card:UIView, CardKind, ConstraintKind{
   /*Stores the constraints, for easy activating and deactivating*/
   public var size:SizeConstraint?
   public var anchor:AnchorConstraint?
   /**/
//   var color:UIColor
//   lazy var textField:UITextField = {
//      let textField = UITextField.init(frame: self.frame)
//      textField.text = "Idx: \(idx)"
//      addSubview(textField)
//      textField.textColor = .black
//      textField.textAlignment = .center
//      textField.font = .boldSystemFont(ofSize: 16)
//      return textField
//   }()
   open var idx: Int
//   {
//      didSet{//after
////         textField.text = "Idx: \(idx)"
////         let color:UIColor = Carousel.items[IntParser.normalize(idx, Carousel.items.count)]
////         backgroundColor = color
//      }
//   }
   public init(/*color:UIColor, */idx:Int, frame:CGRect) {
//      self.color = color
      self.idx = idx
      super.init(frame: frame)
//      backgroundColor = .blue//⚠️️ i guess you could do random color here, self.color
//      _ = textField
   }
   /**
    * Boilerplate
    */
   required public init?(coder aDecoder: NSCoder) {
      fatalError("init(coder:) has not been implemented")
   }
}
