import UIKit
import Carousel

/**
 * TODO: ⚠️️ make onUp,onDown,onMove in Carousel overridable and use point, its just simpler code, makes things easier to reason about
 */
class CardCarousel:Carousel<CardView,UIColor>{
   var downPt:CGPoint = .zero
   var swipeMode:SwipeMode = .none//⚠️️ rename to curSwipeMode
   override init(frame: CGRect) {
      super.init(frame: frame)
//      backgroundColor = .black
   }
   /**
    * Boilerplate
    */
   required init?(coder aDecoder: NSCoder) {
      fatalError("init(coder:) has not been implemented")
   }
   override var items: [UIColor] {get {return [.yellow,.blue,.green,.red] }set { super.items = newValue}}
   /**
    * Creates first card
    */
   override func createFirst(idx:Int) -> CardView{
      let card = createCard(idx: idx)
      //card.frame.origin.x = 0
      setCardConstraints(card, xOffset: 0)
      return card
   }
   /**
    * Creates second card
    */
   override func createSecond(idx:Int) -> CardView{
      let card = createCard(idx: idx)
      setCardConstraints(card, xOffset: UIScreen.main.bounds.width)
      //      card.frame.origin.x = UIScreen.main.bounds.width
      return card
   }
   /**
    * Creates card
    */
   override func createCard(idx:Int) -> CardView{
      let card = CardView.init(idx: idx, frame: UIScreen.main.bounds)
      self.addSubview(card)
      card.isUserInteractionEnabled = false//⚠️️ needed?
      setCardData(card, idx: idx)
      return card
   }
   /**
    * Update data when cards switch
    */
   override func swapCards(_ idx: Int) {
      super.swapCards(idx)
      setCardData(firstCard, idx: idx)
      setCardData(lastCard, idx: idx+1)
   }
   /**
    * TODO: ⚠️️ probaby use onBegan, onUp, on move instad of this. just simpler
    */
   override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
      Swift.print("touchesBegan")
      guard let touch = touches.first/*, touch.view == self*/ else { return }
      let touchPoint = touch.location(in: self)
      downPt = touchPoint//TODO: ⚠️️ We should prob store this in Carousel, by using CGPoint in stead of CGFloat?
      firstCard.middleContent.onDown(y: touchPoint.y)
      super.touchesBegan(touches, with:event)
   }
   /**
    * TODO: ⚠️️ probaby use onBegan, onUp, on move instad of this. just simpler
    */
   override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
      guard let touch = touches.first/*, touch.view == self*/ else { return }
      let touchPoint = touch.location(in: self)
//      Swift.print("touchesMoved().swipeMode:  \(swipeMode)")
      switch swipeMode {
      case .none :
         let dir = DirDetecor.dir(p1:downPt,p2:touchPoint)
         if dir == .hor && abs(touchPoint.x - downPt.x) > 10 {
            swipeMode = .hor
         }else if dir == .ver && abs(touchPoint.y - downPt.y) > 10 {
            swipeMode = .ver
         }else if dir == .none {
            swipeMode = .none
         }
//         prevMovePt = touchPoint
      case .hor :
         super.touchesMoved(touches, with: event)
      case .ver :
//         Swift.print("vertical")
         firstCard.middleContent.onMove(y: touchPoint.y)
         // tell cardView to move middleContent
         // ✅
      }
   }
   /**
    * TODO: ⚠️️ probaby use onBegan, onUp, on move instad of this. just simpler
    */
   override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
      Swift.print("touchesEnded() swipeMode:  \(swipeMode)")
      if swipeMode == .ver {
         firstCard.middleContent.onUp()
      }else if swipeMode == .hor{
         super.touchesEnded(touches, with: event)
      }
      swipeMode = .none//always reset the swipemode on mouseUp
   }
}

/**
 * Accessor
 */
extension CardCarousel{//TODO: ⚠️️ rename to WeatherCardCarousel
   /**
    * Sets data to Card
    */
   func setCardData(_ card:CardView,idx:Int){
      let normalizedIdx:Int = IntParser.normalize(idx, items.count)
      let color:UIColor = items[normalizedIdx]//self.items[idx]//
      let city:City = VC.citiesAndColors[normalizedIdx].city
      card.setData(color: color, city:city)
      DispatchQueue.global(qos: .background).async {
         let coordinate = VC.citiesAndColors[normalizedIdx].city.coordinate
         let loc:Loc = Loc.init(lat:coordinate.lat, long:coordinate.long)
         let hourlyForcast:WeatherModel = MetWeatherService().hourlyForcast(loc:loc)
         DispatchQueue.main.async {//jump back on main thread bc of UI
            card.setWeather(weatherModel: hourlyForcast)
         }
      }
   }
}
