import UIKit
import Carousel
/**
 * TODO: ⚠️️ Rename to WeatherCard, or HorizontalCard?
 */
class CardView:Card{
   static let items:[UIColor] = [.yellow,.blue,.green,.red]
   static let gradients:[[CGColor]] = CardView.createGradients()
   /*Stores the constraints, for easy activating and deactivating*/
//   var size:SizeConstraint?
//   var anchor:AnchorConstraint?
   /*UI*/
   lazy var backgroundLayer:CAGradientLayer = createBackgroundLayer()
   lazy var maskLayer:CAShapeLayer = createMaskLayer()
   lazy var topBar:TopBar = createTopBar()
   lazy var middleContent:MiddleContent2 = createMiddleContent()
//   lazy var bottomBar:BottomBar = createBottomBar()
   lazy var footer:BottomBar = self.createFooter()
   override var idx: Int  {
      didSet{//after
//         textField.text = "Idx: \(idx)"
         let i:Int = IntParser.normalize(idx, CardView.items.count)
//         let color:UIColor = CardView.items[]
         let gradientColors:[CGColor] = CardView.gradients[i]
         backgroundLayer.colors = gradientColors
//         middleContent.backgroundColor = color
      }
   }
   override init(/*color:UIColor, */idx:Int, frame:CGRect) {
//      self.idx = idx
      super.init(idx:idx, frame: frame)
       _ = backgroundLayer
      _ = maskLayer
      _ = topBar
      _ = middleContent
//      let color:UIColor = CardView.items[IntParser.normalize(idx, CardView.items.count)]
//      middleContent.backgroundColor = color
//      _ = bottomBar
      _ = footer
//      _ = textField
   }
   required init?(coder aDecoder: NSCoder) {
      fatalError("init(coder:) has not been implemented")
   }
}
