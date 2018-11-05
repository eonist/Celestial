import UIKit
import Spatial

class VerticalCard:UIView, ConstraintKind{
   /*Constraints*/
   public var size:SizeConstraint?
   public var anchor:AnchorConstraint?
   /*UI*/
   
   override init(frame: CGRect) {
      super.init(frame: frame)
     
   }
   /**
    * Boilerplate
    */
   required init?(coder aDecoder: NSCoder) {
      fatalError("init(coder:) has not been implemented")
   }
}
/**
 * Create
 */
extension VerticalCard{
   
}
