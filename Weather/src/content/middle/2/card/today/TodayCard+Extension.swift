import UIKit
import Spatial

//🏀
//secondcard should have 5 different items Hour, weather img, weathertype, degree 👈

extension TodayCard{
   /**
    * New
    */
   func createHourViews() -> [HourView] {
      let size:CGSize = CGSize.init(width: self.frame.width, height: 48)
      let itemViews:[HourView] = (0..<5).indices.map{ i in
         let itemView = HourView.init(frame: .init(origin: .zero, size: size))//.init(origin: .zero, size: size)
         self.addSubview(itemView)
         return itemView
      }
      itemViews.activateConstraint { views in /*All vertically centered, 48p height each*/
         let anchors = Constraint.distribute(vertically: views, align: .topLeft)
         let sizes = views.map{Constraint.size($0, size: size)}
         return (anchors, sizes)
      }
      //      Swift.print("itemViews:  \(itemViews)")
      return itemViews
   }
}
