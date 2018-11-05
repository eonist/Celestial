import UIKit
import Carousel

class CardView:Card{
   static let items:[UIColor] = [.yellow,.blue,.green,.red]
   /*Stores the constraints, for easy activating and deactivating*/
//   var size:SizeConstraint?
//   var anchor:AnchorConstraint?
   /*UI*/
   lazy var backgroundLayer:CALayer = createBackgroundLayer()
   lazy var maskLayer:CAShapeLayer = createMaskLayer()
   lazy var topBar:TopBar = createTopBar()
   lazy var cardContent:MiddleContent = createMiddleContent()
   lazy var bottomBar:BottomBar = createBottomBar()
   override var idx: Int  {
      didSet{//after
//         textField.text = "Idx: \(idx)"
         let color:UIColor = CardView.items[IntParser.normalize(idx, CardView.items.count)]
         cardContent.backgroundColor = color
      }
   }
   init(color:UIColor, idx:Int, frame:CGRect) {
//      self.idx = idx
      super.init(idx:idx, frame: frame)
      _ = backgroundLayer
      _ = maskLayer
      _ = topBar
      _ = cardContent
//      let color:UIColor = CardView.items[IntParser.normalize(idx, CardView.items.count)]
      cardContent.backgroundColor = color
      _ = bottomBar
//      _ = textField
   }
   required init?(coder aDecoder: NSCoder) {
      fatalError("init(coder:) has not been implemented")
   }
}
