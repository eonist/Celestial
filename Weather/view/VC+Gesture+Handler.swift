import UIKit

extension VC{
    /**
     * Adds gesture recognizers
     */
    func addGestures(){
        /*Tap*/
        let tap = UITapGestureRecognizer(target: self, action:  #selector(handleTap))
        self.view.addGestureRecognizer(tap)
        /*Pan*/
        let pan = UIPanGestureRecognizer(target:self, action:#selector(handlePan))
        self.view.addGestureRecognizer(pan)
    }
    /**
     * Normal tap
     */
    @objc func handleTap(sender : UITapGestureRecognizer) {
//        Swift.print("handleTap")
        if [.ended,.cancelled,.failed].contains(sender.state) {/*on tap release*/
            onTapRelease()
        }
    }
    /**
     * When user release tap (regular tap, or drag tap)
     */
    private func onTapRelease(){
//        Swift.print("onTapRelease()")
        let screenRect = UIScreen.main.bounds
        var leftBoundry:CGFloat {return screenRect.origin.x - screenRect.size.width/4 }
        var rightBoundry:CGFloat {return screenRect.size.width + screenRect.size.width / 4 }
        self.view.isUserInteractionEnabled = false/*disable userinteractions, while animation is playing*/
        if curView.frame.origin.x < leftBoundry {/*more 25% to the left*/
            beyondLeft()
        }else if (curView.frame.origin.x + curView.frame.width) > rightBoundry {/*more than 25% to the right*/
            beyondRight()
        }else {/*released within boundries*/
            withinBoundry()
        }
        self.view.layoutIfNeeded()/*visual update*/
    }
    /**
     * When user drags a tap across the screen
     */
   @objc func handlePan(recognizer:UIPanGestureRecognizer) {
      let translation = recognizer.translation(in: self.view)
      //Swift.print("translation:  \(translation)")
      guard let posConstraint = curView.anchor else {fatalError("err posConstraint not available")}
      let x = posConstraint.x.constant + translation.x
      curView.update(offset: x, align: .left, alignTo: .left)
      /**/
      recognizer.setTranslation(.zero, in: self.view)/*reset recognizer*/
      if [.ended,.cancelled,.failed].contains(recognizer.state)   {
         onTapRelease()/*call tapRelease*/
      }
   }
}



