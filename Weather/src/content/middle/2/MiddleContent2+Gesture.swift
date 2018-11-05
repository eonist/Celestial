import UIKit

extension MiddleContent2{
   /**
    * Down
    */
   func onDown(y:CGFloat){
      Swift.print("onDown() containerY:\(containerY)")
      downY = y
      downContainerY = containerY
   }
   /**
    * Move
    */
   func onMove(y:CGFloat){
      Swift.print("onMove")
      let diff = y - downY
      Swift.print("diff:  \(diff)")
      let newY = downContainerY + diff      
      moveCards(y:newY)
   }
   /**
    * Up
    */
   func onUp(/*y:CGFloat*/){
      Swift.print("onUp")
      //determine to anim or not

      //if curX
      let remainder:CGFloat = containerY.remainder(dividingBy: self.frame.height)//truncatingRemainder(dividingBy: )
      Swift.print("remainder:  \(remainder)")
      let diff:CGFloat = (containerY - downContainerY)
      Swift.print("diff:  \(diff)")
      if diff == 0{/*click without movment*/
         Swift.print("click without movment")
         if animator.from == animator.to {return}
         animator.from < animator.to ? animateUp() : animateDown()//find direction of last anim, and start the similar anim
      }else if abs(remainder) > UIScreen.main.bounds.width/4 {
         if diff < 0 {
//            Swift.print("👉")
            animateUp()
         }else if diff > 0 {
//            Swift.print("👈")
            animateDown()
         }
      }else{/*within threshold*/
//         Swift.print("👇")
         animateToIdle()
      }
   }
}
