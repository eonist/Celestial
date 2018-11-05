import UIKit
import Spatial

class HourView:UIView{
   lazy var hourLabel:UILabel = createHourLabel()
   lazy var weatherIcon:UIImageView = createWeatherIcon()
   lazy var kindLabel:UILabel = createkindLabel()
   lazy var degLabel:UILabel = createDeglabel()
   
   override init(frame: CGRect) {
      super.init(frame: frame)
      backgroundColor = .green
      /*UI*/
      _ = hourLabel
      _ = degLabel
      _ = kindLabel
      _ = weatherIcon
      /*Constraints*/
      makeConstraints()
   }
   /**
    * Boilerplate
    */
   required init?(coder aDecoder: NSCoder) {
      fatalError("init(coder:) has not been implemented")
   }
}
/**
 * HourView
 */
extension HourView {
  
   /**
    * Creates hour label
    */
   func createHourLabel() -> UILabel {
      let label = UILabel()
      label.text = "17:00"
      label.font = label.font.withSize(16)
      label.textAlignment = .center
      label.backgroundColor = .darkGray
      label.textColor = .black//UIColor(hex:"EBCF4B")
      self.addSubview(label)
      return label
   }
   /**
    * WeatherIcon
    */
   func createWeatherIcon() -> UIImageView{//38
      let view = UIImageView()
      view.backgroundColor = .purple
      self.addSubview(view)
      return view
   }
   /**
    * DegLabel
    */
   func createDeglabel() -> UILabel{
      let label = UILabel()
      label.text = "5°C"
      label.font = UIFont.boldSystemFont(ofSize: 16)
      label.textAlignment = .center
      label.backgroundColor = .white
      label.textColor = .black//UIColor(hex:"EBCF4B")
      self.addSubview(label)
      return label
   }
   /**
    * kindLabel
    * NOTE: weather type api: https://api.met.no/weatherapi/weathericon/_/documentation/
    */
   func createkindLabel() -> UILabel{
      Swift.print("createkindLabel()")
      let kindLabel = UILabel()
      kindLabel.text = "Clear skies"
      kindLabel.font = kindLabel.font.withSize(16)
      kindLabel.textAlignment = .center
      kindLabel.backgroundColor = .darkGray
      kindLabel.textColor = .black//UIColor(hex:"EBCF4B")
      self.addSubview(kindLabel)
      return kindLabel
   }
}
/**
 * Constraints
 */
extension HourView{
   /**
    * Adds constraints
    */
   func makeConstraints(){
      let size:CGSize = CGSize(width: ceil((self.frame.width-38)/3), height: 38)
      [hourLabel,weatherIcon,kindLabel,degLabel].activateConstraint { views in
         let anchors = Constraint.distribute(horizontally: views, align: .centerLeft)
         let sizes:[SizeConstraint] = views.map{
            if $0 === weatherIcon {
               return Constraint.size($0, size: CGSize(width: 38, height: 38))
            }else{
               return Constraint.size($0, size:size)
            }
         }
         return (anchors, sizes)
      }
   }
}
