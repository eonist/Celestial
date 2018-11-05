import UIKit

//get rid of container ✅
//add the remainder code to set the correct color, see IntParser.loop for quick memory jog ✅
//Add Spatial ✅
//add the nice design ✅
//add easing methods from Animator 👈👈
//add text elements ✅
//add image elements ✅
//add days ✅
//Make CarouselCard overridable, use generics ✅
//make things public and open in Spatial ✅
//Add spatial to carousel as .framework ✅
//add spatial to carousel as carthage ✅
//Try to add Carousel as .framework to weatherApp 👈
//Add carousel to weatherApp as carthage once it works
//add spatial to weatherapp as carthage
//See if it all works
//Make the project nice
//Maybe add HOurly forcast on swipe up? 👌 
//get TravisCI to work with building carthage via demo project first

open class Carousel<T:UIView,U>:UIView where T:CardKind{//⚠️️ cardView should be T,U:CardKind where U :UIView etc
   open var items:[U] = []//⚠️️ TODO: make this generic instead T, make sure that works with overriding
   /*UI*/
   public lazy var firstCard:T = self.createFirst(idx: 0)
   public lazy var lastCard:T = self.createSecond(idx: 1)
   /*Interim*/
   var containerX:CGFloat = 0/*Virtual X value of cardContainer*/
   var downX:CGFloat = 0
   var downContainerX:CGFloat = 0
   var idx:Int = 0
   /*Animation*/
   lazy var animator:CarouselAnimator = CarouselAnimator(duration:0.3)
   override public init(frame:CGRect){
		super.init(frame:frame)
      self.backgroundColor = .gray
      self.isUserInteractionEnabled = true
      _ = firstCard
      _ = lastCard
	}
   required public init?(coder aDecoder: NSCoder) {
      fatalError("init(coder:) has not been implemented")
   }
   /**
    * On tap down inside
    */
   override open func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
//      Swift.print("touchesBegan")
      if  let touch = touches.first/*, touch.view == self*/ {
         let touchPoint = touch.location(in: self)
         onDown(touchPoint)
      }
      super.touchesBegan(touches, with:event)
   }
   /**
    * On tap up inside
    */
   override open func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
//      Swift.print("touchesEnded")
      if  let touch = touches.first/*, touch.view == self*/ {
         let touchPoint = touch.location(in: self)
         onUp(touchPoint)
      }
      super.touchesEnded(touches, with:event)
   }
   override open func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
      if let touch = touches.first /*, touch.view == self*/ {
         let touchPoint = touch.location(in: self)
         onMove(touchPoint)
      }
      super.touchesMoved(touches, with: event)
   }
   /**
    * Creates first card
    */
   open func createFirst(idx:Int) -> T{
      fatalError("must be overriden in subclass")
   }
   /**
    * Creates second card
    */
   open func createSecond(idx:Int) -> T{
      fatalError("must be overriden in subclass")
   }
   /**
    * Creates card
    */
   open func createCard(idx:Int) -> T{
      fatalError("must be overriden in subclass")
   }
   /**
    * Called by moveCards
    * NOTE: Override this to set custom data to the cards
    */
   open func swapCards(_ idx:Int){
      Swift.swap(&firstCard, &lastCard)
      firstCard.idx = idx
      lastCard.idx = idx + 1//⚠️️ strictly speaking the +1 should be the diff of curIdx and idx, etc,etc, but only relevant if setIdx is implemented on the carousel
   }
}
