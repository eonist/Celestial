import UIKit
import Spatial

class NowCard:VerticalCard {
   /*UI*/
   lazy var degLabel:UILabel = createDeglabel()
   lazy var kindLabel:UILabel = createkindLabel()
   lazy var weatherIcon:UIImageView = createWeatherIcon()
   override init(frame: CGRect) {
      super.init(frame: frame)
//      self.backgroundColor = .lightGray
      _ = degLabel
      _ = kindLabel
      _ = weatherIcon
   }
   /**
    * Boilerplate
    */
   required init?(coder aDecoder: NSCoder) {
      fatalError("init(coder:) has not been implemented")
   }
}
