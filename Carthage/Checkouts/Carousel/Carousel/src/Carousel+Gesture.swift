import UIKit
/**
 * Gesture
 */
extension Carousel{
   /**
    * onDown
    */
   func onDown(_ point:CGPoint){
      Swift.print("onDown \(point)")
      animator.stop()
      self.downX = point.x
      //self.downIdx = idx
      self.downContainerX = containerX
   }
   /**
    * onUp
    */
   func onUp(_ point:CGPoint){
      Swift.print("onUp \(point.x) 👆")
      let remainder:CGFloat = containerX.remainder(dividingBy: UIScreen.main.bounds.width)//truncatingRemainder(dividingBy: )
//      Swift.print("remainder:  \(remainder)")
      let diff:CGFloat = containerX - downContainerX
//      Swift.print("diff:  \(diff)")
      if diff == 0{/*click without movment*/
         Swift.print("click without movment")
         if animator.from == animator.to {return}
         animator.from < animator.to ? animateLeft() : animateRight()//find direction of last anim, and start the similar anim
      }else if abs(remainder) > UIScreen.main.bounds.width/4 {
         if diff > 0 {
//            Swift.print("👉")
            animateLeft()
         }else if diff < 0 {
//            Swift.print("👈")
            animateRight()
         }
      }else{/*within threshold*/
//         Swift.print("👇")
         animateToIdle(isBeyondLeft: diff < 0)
      }
   }
   /**
    * onMove
    */
   func onMove(_ point:CGPoint){
      //    Swift.print("onMove \(point)")
      let newX = containerX + (point.x - self.downX)
      self.downX = point.x//we reset downX, so we dont have to store cardContainer.x as well
      //Swift.print("newX:  \(newX)")
      moveCards(x: newX)
   }
}

