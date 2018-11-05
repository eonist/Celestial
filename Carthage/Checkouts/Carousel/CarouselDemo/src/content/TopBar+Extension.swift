import UIKit
import Spatial
/**
 * Create
 */
extension TopBar {
   /**
    * TODO: ⚠️️ Make the header it's own class
    */
   func createHeaderTitle() -> UILabel{
      let label = UILabel()
//      guard let cardView:CardView = self.superview as? CardView else {fatalError("err")}
      let location:String = Const.citiesAndColors[0].city.cityName 
      
      label.font = label.font.withSize(20)
      label.textAlignment = .center
      label.text = location
      label.backgroundColor = .green
      label.textColor = .black//UIColor(hex:"EBCF4B")
      self.addSubview(label)
      label.activateConstraint{ label in
         let anchor = Constraint.anchor(label, to: self, align:.centerCenter, alignTo: .centerCenter)
         let height = Constraint.height(label, height: 30)
         let width = Constraint.width(label, to: self)
         return [anchor.x,anchor.y,width,height]
      }
      return label
   }
}
