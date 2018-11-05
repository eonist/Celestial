import UIKit
import Spatial


extension MiddleContent2 {
   /**
    * First
    */
	func createFirstCard() -> NowCard{
      let card = NowCard.init(frame: UIScreen.main.bounds)
      self.addSubview(card)
      card.isUserInteractionEnabled = false//⚠️️ needed?
//      card.backgroundColor = .cyan
		setCardConstraints(card,yOffset:0)
		return card
	}
   /**
    * Second
    */
	func createSecondCard() -> TodayCard{
      let card = TodayCard.init(frame: self.frame)
      self.addSubview(card)
      card.isUserInteractionEnabled = false//⚠️️ needed?
//      card.backgroundColor = .magenta
		setCardConstraints(card,yOffset:self.frame.height)
		return card
	}
	/**
    * Align card
    */
   public func setCardConstraints(_ card:ConstraintKind.UIViewConstraintKind,yOffset:CGFloat){//⚠️️ TODO: make generic
      let screenSize:CGSize = {
         let size = self.frame.size
         return CGSize(width:size.width, height:size.height)
      }()
      card.applyConstraint{ view in
         let size:SizeConstraint = Constraint.size(card, size: screenSize)
         let anchor:AnchorConstraint = Constraint.anchor(card, to: self, align: .topLeft, alignTo: .topLeft, offset:CGPoint(x:0,y:yOffset))
         return (anchor:anchor, size:size)
      }
   }
}
