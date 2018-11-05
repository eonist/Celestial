
import UIKit
/**
 * Animation
 */
extension Carousel{
   
   /**
    * Animates cards fróm right to left
    */
   func animateLeft(){
      Swift.print("animateLeft 👌")
      let from = containerX
      let to = CGFloat(self.idx) * -UIScreen.main.bounds.width
      animate(to: to, from: from)
   }
   /**
    * Animates cards fróm left to right
    * NOTE: Moves cards from left to right
    */
   func animateRight(){
      Swift.print("animateRight 👌")
      let from = containerX
      let to = CGFloat(self.idx+1) * -UIScreen.main.bounds.width
      animate(to: to, from: from)
   }
   /**
    * Animates cards to idle position
    * NOTE: basically when the gesture is dropped within left and right boundry
    */
   func animateToIdle(isBeyondLeft:Bool){
      Swift.print("animateToIdle 👌")
      let from = containerX
      let to = CGFloat(self.idx + (isBeyondLeft ? 0:1)) * -UIScreen.main.bounds.width
      animate(to: to, from: from)
   }
   private func animate(to:CGFloat,from:CGFloat){
      animator.reset()
      let dist = abs(to - from)
//      Swift.print("dist:  \(dist)")
      let fraction = dist / UIScreen.main.bounds.width
//      Swift.print("fraction:  \(fraction)")
      let defaultDur:TimeInterval = 0.3
      animator.duration = Double(defaultDur) * Double(fraction)
//      Swift.print("animator.totalCount:  \(animator.totalCount)")
      animator.from = from
      animator.to = to
      animator.tick = {
         let x = TimeAnimator.interpolate(from: self.animator.from, to: self.animator.to, fraction: self.animator.progress)
         self.moveCards(x: x)
      }
      animator.onComplete = {//quick hack so that the click withouth movment works. , should be solved elsewhere 
         self.animator.from = 0
         self.animator.to = 0
      }
      animator.start()
   }
}
