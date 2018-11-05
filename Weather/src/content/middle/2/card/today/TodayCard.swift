import UIKit
import Spatial

class TodayCard:VerticalCard{
   /*UI*/
   lazy var hourViews:[HourView] = createHourViews()
   override init(frame: CGRect) {
      super.init(frame: frame)
//      self.backgroundColor = .blue
//      let bg = UIView()
//      bg.autoresizingMask = [.flexibleWidth, .flexibleHeight]
//      bg.backgroundColor = .blue
//      self.addSubview(bg)/*Add a background to*/
//      self.axis = .vertical/*arrange subViews horizontally*/
//      self.distribution  = .fill
//      self.spacing = 10
//      self.alignment = .fill//doesn't matter
//      self.spacing = 0/*zero gaps between view*/
      _ = hourViews
   }
   /**
    * Boilerplate
    */
   required init(coder: NSCoder) {
      fatalError("init(coder:) has not been implemented")
   }
}
