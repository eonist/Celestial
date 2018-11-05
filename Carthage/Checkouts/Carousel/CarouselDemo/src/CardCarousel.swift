import UIKit
import Carousel

class CardCarousel:Carousel<CardView,UIColor>{
   override var items: [UIColor] {
      get {
         return [.yellow,.blue,.green,.red]
      }set {
         super.items = newValue
      }
   }
   /**
    * Creates first card
    */
   override func createFirst(idx:Int) -> CardView{
      let card = createCard(idx: idx)
      //      card.frame.origin.x = 0
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
      let card = CardView.init(color: self.items[idx],idx: idx, frame: UIScreen.main.bounds)
      self.addSubview(card)
      card.isUserInteractionEnabled = false//⚠️️ needed?
      return card
   }
   override func swapCards(_ idx: Int) {
      super.swapCards(idx)
//      firstCard.setData(color,city)
//      secondCard.setData(color,city)
   }
}
