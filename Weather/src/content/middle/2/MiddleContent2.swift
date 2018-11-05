import UIKit
import Carousel

class MiddleContent2:UIView{
	lazy var animator:CarouselAnimator = CarouselAnimator(duration:0.3)
   var cardMode:CardMode = .now/*now or today*/
   /*UI*/
   lazy var firstCard:NowCard = createFirstCard()
   lazy var secondCard:TodayCard = createSecondCard()
   /*Interim*/
   var containerY:CGFloat
   var downContainerY:CGFloat
   var downY:CGFloat = 0/*related to touch point onTouchDown*/
   //
   
   override init(frame: CGRect) {
      downContainerY = 0//-frame.height
      containerY = 0//-frame.height
      super.init(frame: frame)
//      self.backgroundColor = .lightGray
//      self.backgroundColor = .gray
//      self.layer.addSublayer(gradientLayer)//
//      self.layer.insertSublayer(gradientLayer, at: 0)
//      gradientLayer.frame = CGRect.init(x: 12, y: 12, width: frame.width-24, height: frame.height-24)
//      gradientLayer.cornerRadius = 24
      /*Mask*/
      _ = {//mask this view
         let maskLayer = CAShapeLayer()
         let path = CGPath(rect: frame, transform: nil)
         maskLayer.path = path
         self.layer.mask = maskLayer// Set the mask of the view.
      }()
      _ = firstCard
      _ = secondCard
   }
   /**
    * Boilerplate
    */
   required init?(coder aDecoder: NSCoder) {
      fatalError("init(coder:) has not been implemented")
   }
}



//let height = self.frame.height - margin.top.bottom-topbarheight-bottombarheight
//add it
//make bottombar align to bottom of contentview
//look at weatherApp gesture code
