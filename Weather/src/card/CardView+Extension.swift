import UIKit
import Spatial
//import Carousel

extension CardView{
   /**
    * Creates bg layer
    */
   func createBackgroundLayer() -> CAGradientLayer{
      let gradientLayer = CAGradientLayer()
      gradientLayer.frame = self.frame
      Swift.print("view.frame:  \(self.frame)")
      gradientLayer.colors = CardView.gradients[0]//[UIColor(hex: "17ead9").cgColor, UIColor(hex: "6078ea").cgColor]
      self.layer.addSublayer(gradientLayer)//self.layer.insertSublayer(gradient, at: 0)
      return gradientLayer
   }
   /**
    * Creates and applies mask to view
    */
   func createMaskLayer() -> CAShapeLayer{
      let maskLayer = CAShapeLayer()
      let insetFrame:CGRect = CGRect.init(x: CardView.margin.left, y: CardView.margin.top, width: self.frame.width - (CardView.margin.left + CardView.margin.right)  , height: self.frame.height - (CardView.margin.top + CardView.margin.bottom))
      let path = UIBezierPath.init(roundedRect: insetFrame, cornerRadius: 24)
      maskLayer.path = path.cgPath
      self.layer.mask = maskLayer//applies the mask to the view
      return maskLayer
   }
   /**
    * Creates topBar
    */
   func createTopBar() -> TopBar{
      let topBar:TopBar = .init(frame: .zero)
      self.addSubview(topBar)
      topBar.activateConstraint { view in
         let anchor = Constraint.anchor(view, to: self, align: .topLeft, alignTo: .topLeft, offset:CGPoint(x:CardView.margin.left,y:CardView.margin.top))
         let size = Constraint.size(view, size: CGSize.init(width: UIScreen.main.bounds.width-CardView.margin.left-CardView.margin.left, height: TopBar.topBarHeight))
         return [anchor.x,anchor.y,size.w,size.h]
      }
      return topBar
   }
   /**
    * Creates the middle card content view
    */
   func createMiddleContent() -> MiddleContent2{
      let width:CGFloat = self.frame.width - (CardView.margin.left + CardView.margin.right)
      let height:CGFloat = self.frame.height - (TopBar.topBarHeight + BottomBar.bottomBarHeight + CardView.margin.top + CardView.margin.bottom)
      let rect:CGRect = .init(origin: .zero, size: .init(width: width, height: height))
      let cardContent = MiddleContent2.init(frame: rect)
      self.addSubview(cardContent)
      cardContent.activateConstraint { view in
         let anchor = Constraint.anchor(view, to: topBar, align: .topLeft, alignTo: .bottomLeft, offset:.zero)
         let size = Constraint.size(view, size: rect.size)
         return [anchor.x,anchor.y,size.w,size.h]
      }
      return cardContent
   }
   /**
    * Creates bottomBar
    */
//   func createBottomBar() -> BottomBar {
//      let bottomBar:BottomBar = .init(frame: .zero)
//      self.addSubview(bottomBar)
//      bottomBar.activateConstraint { view in
//         let anchor = Constraint.anchor(view, to: middleContent, align: .topLeft, alignTo: .bottomLeft, offset:.zero)
//         let size = Constraint.size(view, size: CGSize.init(width: UIScreen.main.bounds.width-CardView.margin.left-CardView.margin.left, height: BottomBar.bottomBarHeight))
//         return [anchor.x,anchor.y,size.w,size.h]
//      }
//      return bottomBar
//   }
   /**
    * Creates footer
    */
   func createFooter() -> BottomBar{
      let size:CGSize = .init(width:UIScreen.main.bounds.width-CardView.margin.left-CardView.margin.left,height:BottomBar.bottomBarHeight)
      let footer = BottomBar.init(frame: .init(origin: .zero, size: size))
      self.addSubview(footer)
      footer.activateConstraint{ view in /*constraints*/
         let anchor = Constraint.anchor(footer, to: middleContent, align: .topLeft, alignTo: .bottomLeft,offset:.zero)/*Its strange that this works, since pages are added to view, and view should be full-screen*/
//         let screenSize = UIScreen.main.bounds.size
         let size = Constraint.size(footer, size: CGSize(width:size.width,height:size.height))/*Footer.footerHeight*/
         return [anchor.x,anchor.y,size.w,size.h]
      }
      footer.updateWeather(idx: self.idx)/*init*/
      return footer
   }
}
/**
 * Accessor
 */
extension CardView{
   /**
    *
    */
   func setWeather(weatherModel:WeatherModel){
      middleContent.setWeather(weatherModel:weatherModel)
   }
   /**
    *
    */
   func setData(color:UIColor, city:City){
      middleContent.setBackgroundColor(color:color)
      topBar.headerTitle.text = city.cityName
//      middleContent.degLabel.text = ""
//      middleContent.kindLabel.text = ""
//      middleContent.weatherIcon = UIImageView()
   }
}
/**
 * Utils
 */
extension CardView{
   static let margin:UIEdgeInsets = .init(top: 24, left: 12, bottom: 24, right: 12)
   /**
    * Creates gradients
    */
   static func createGradients() -> [[CGColor]]{
      let yellowOrange:[UIColor] = [UIColor(hex:"FCE38A"), UIColor(hex:"F38181")]
      let pinkOrange:[UIColor] = [UIColor(hex:"F54EA2"), UIColor(hex:"FF7676")]
      let greenLightblue:[UIColor] = [UIColor(hex:"42E695"), UIColor(hex:"3BB2B8")]
      let purpleBlue:[UIColor] = [UIColor(hex:"F02FC2"), UIColor(hex:"6094EA")]
      let grayPurple:[UIColor] = [UIColor(hex:"65799B"), UIColor(hex:"5E2563")]
      let orangePurple:[UIColor] = [UIColor(hex:"74276C"), UIColor(hex:"C53364"), UIColor(hex:"FD8263")]
      let bluePurple:[UIColor] = [UIColor(hex:"274B74"), UIColor(hex:"8233C5"), UIColor(hex:"E963FD")]
      let purpleOrange:[UIColor] = [UIColor(hex:"879AF2"), UIColor(hex:"D3208B"), UIColor(hex:"FDA000")]
      let blueGreen:[UIColor] = [UIColor(hex:"574BCD"), UIColor(hex:"2999AD"),UIColor(hex:"41E975")]
      let purplePurple:[UIColor] = [UIColor(hex:"363553"), UIColor(hex:"903775"),UIColor(hex:"E8458B")]
      let blueBlue:[UIColor] = [UIColor(hex:"5C2774"), UIColor(hex:"335CC5"),UIColor(hex:"637FFD")]
      let gradients:[[UIColor]] = [yellowOrange,pinkOrange,greenLightblue,purpleBlue,grayPurple,orangePurple,bluePurple,purpleOrange,blueGreen,purplePurple,blueBlue]
      return gradients.map{$0.map{color in color.cgColor}}
   }
}
