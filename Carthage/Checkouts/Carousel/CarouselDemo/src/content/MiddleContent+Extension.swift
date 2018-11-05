import UIKit
//import Carousel//should import Spatial
import Spatial

extension MiddleContent{
   /**
    * DegLabel
    */
   func createDeglabel() -> UILabel{
      let degLabel = UILabel()
      degLabel.text = "5°C"
      degLabel.font = UIFont.boldSystemFont(ofSize: 60.0)
      degLabel.textAlignment = .center
      degLabel.backgroundColor = .white
      degLabel.textColor = .black//UIColor(hex:"EBCF4B")
      self.addSubview(degLabel)
      let width:CGFloat = 200
      degLabel.activateConstraint{ view in
         let anchor = Constraint.anchor(view, to: self, align:.centerCenter, alignTo: .centerCenter)
         let size = Constraint.size(view, size: .init(width:width,height:width))
         return [anchor.x,anchor.y,size.w,size.h]
      }
      return degLabel
   }
   /**
    * kindLabel
    * NOTE: weather type api: https://api.met.no/weatherapi/weathericon/_/documentation/
    */
   func createkindLabel() -> UILabel{
      Swift.print("createkindLabel()")
      let kindLabel = UILabel()
      kindLabel.text = "Clear skies"
      kindLabel.font = kindLabel.font.withSize(20)
      kindLabel.textAlignment = .center
      kindLabel.backgroundColor = .lightGray
      kindLabel.textColor = .black//UIColor(hex:"EBCF4B")
      self.addSubview(kindLabel)
      kindLabel.activateConstraint{ view in
         let anchor = Constraint.anchor(view, to: self.degLabel, align:.topCenter, alignTo: .bottomCenter)
         let height = Constraint.height(view, height: 40)
         let width = Constraint.width(view, to: self)
         return [anchor.x,anchor.y,width,height]
      }
      return kindLabel
   }
   /**
    * WeatherIcon
    */
   func createWeatherIcon()->UIImageView{
      let view = UIImageView()
              view.backgroundColor = .purple
      self.addSubview(view)
      view.activateConstraint{ view in
         let anchor = Constraint.anchor(view, to: self.degLabel, align:.bottomCenter, alignTo: .topCenter)
         let height = Constraint.height(view, height: 38)
         let width = Constraint.width(view, width:38)
         return [anchor.x,anchor.y,width,height]
      }
      return view
   }
}
