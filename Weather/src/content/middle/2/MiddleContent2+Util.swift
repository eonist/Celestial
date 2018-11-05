import UIKit
import Spatial

extension MiddleContent2{
	/**
	 * Moves cards
	 */
   func moveCards(y:CGFloat){
      containerY = y//this is the only place that sets containerY val
      firstCard.update(offset: y, align: .top, alignTo: .top)
      secondCard.update(offset: y + self.frame.height, align: .top, alignTo: .top)
   }
}
extension MiddleContent2{
   enum CardMode{
      case now,today
   }
}
