import UIKit
import Carousel

extension MiddleContent2{
	/**
    * Animates cards fróm right to left
    */
   func animateUp(){
      Swift.print("animateUp 👌")
      let from = containerY
      let to = -self.frame.height
      animate(to: to, from: from)
   }
   /**
    * Animates cards fróm left to right
    * NOTE: Moves cards from left to right
    */
   func animateDown(){
      Swift.print("animateDown 👌")
      let from = containerY
      let to:CGFloat = 0
      animate(to: to, from: from)
   }
   /**
    * Animates cards to idle position
    * NOTE: basically when the gesture is dropped within left and right boundry
    */
   func animateToIdle(/*isBeyondTop:Bool*/){
      Swift.print("animateToIdle 👌")
      let from = containerY
		let remainder:CGFloat = containerY.remainder(dividingBy: self.frame.height)
      Swift.print("remainder:  \(remainder)")
      let to = containerY - remainder
//      if containerY
      animate(to: to, from: from)
   }
   private func animate(to:CGFloat,from:CGFloat){//⚠️️ this should be from,to
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
         let y = TimeAnimator.interpolate(from: self.animator.from, to: self.animator.to, fraction: self.animator.progress)
         self.moveCards(y: y)
      }
      animator.onComplete = {
         self.cardMode = self.animator.to == 0 ? .now : .today
         self.animator.from = 0//quick hack so that the click withouth movment works. , should be solved elsewhere
         self.animator.to = 0
      }
      animator.start()
   }
}
