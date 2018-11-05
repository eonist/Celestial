import UIKit
import Spatial
/**
 * Cases
 */
extension VC{
   /**
    * Handle paning beyond the left boundry
    * NOTE: basically swipe right to left, where the left side page disapears
    * NOTE: Moves cards from right to left
    */
    func beyondLeft(){
        Swift.print("outside left boundry")
        let screenRect = UIScreen.main.bounds
        let to:CGFloat = screenRect.origin.x - screenRect.width
        self.animate(to: to) { /*onComplete closure*/
            Swift.print("swap the views around 🎉")
            self.curIdx += 1/*progress the index by 1*/
            self.leftView.removeFromSuperview()/*leftView is now removed as its completly sight*/
            /**/
            self.leftView = self.curView /*curView now becomes leftView*/
            if let anchor = self.leftView.anchor/*, let size = self.leftView.size*/ {
                NSLayoutConstraint.deactivate([anchor.x,anchor.y])
            }
            self.curView = self.rightView/*rightView now becomes curView */
            if let anchor = self.curView.anchor/*, let size = self.curView.size */{
                NSLayoutConstraint.deactivate([anchor.x,anchor.y])
            }
            self.setCenterConstraints(self.curView)/*set final constraint*/
            self.setLeftConstraints(self.leftView)/*set final constraint*/
            /**/
            let newRightIdx = IntParser.normalize(self.curIdx + 1, VC.citiesAndColors.count)/*loopy index*/
            self.rightView = self.createRightView(idx: newRightIdx)/*Create a new right page, since the cur right becomes cur page*/
            let normalizedCurIdx = IntParser.normalize(self.curIdx, VC.citiesAndColors.count)/*loopy index*/
            self.footer.updateWeather(idx: normalizedCurIdx)
            self.view.isUserInteractionEnabled = true/*enable userinteractions*/
        }
    }
    /**
     * Handle paning beyond the right boundry
     * Basically swipe from left to right
     * NOTE: Moves cards from left to right
     */
    func beyondRight(){
        Swift.print("outside right boundry")
        let screenRect = UIScreen.main.bounds
        let to:CGFloat = screenRect.origin.x + screenRect.width
        animate(to:to){/*onComplete closure*/
            Swift.print("Swap the views around 👌")
            self.curIdx -= 1
            self.rightView.removeFromSuperview()
            /**/
            self.rightView = self.curView/*the prev page is now cur page*/
            if let anchor = self.rightView.anchor/*, let size = self.rightView.size*/ {
                NSLayoutConstraint.deactivate([anchor.x,anchor.y])
            }
            self.curView = self.leftView
            if let anchor = self.curView.anchor/*, let size = self.curView.size*/ {
                NSLayoutConstraint.deactivate([anchor.x,anchor.y])
            }
            self.setCenterConstraints(self.curView)/*set final constraint*/
            self.setRightConstraints(self.rightView)/*set final constraint*/
            /**/
            let newLeftIdx = IntParser.normalize(self.curIdx - 1, VC.citiesAndColors.count)/*loopy index*/
            self.leftView = self.createLeftView(idx: newLeftIdx)/*Since the prev left is now cur, make a new left*/
            let normalizedCurIdx = IntParser.normalize(self.curIdx, VC.citiesAndColors.count)/*loopy index*/
            self.footer.updateWeather(idx: normalizedCurIdx)
            self.view.isUserInteractionEnabled = true/*enable userinteractions*/
        }
    }
    /**
     * Handle paning within boundry
     * NOTE: basically when the gesture is dropped within left and right boundry
     */
    func withinBoundry(){
        Swift.print("within boundries")
        let screenRect = UIScreen.main.bounds
        let to:CGFloat = screenRect.origin.x
        animate(to:to){/*onComplete closure*/
            Swift.print("swap the views around ✅")
            self.view.isUserInteractionEnabled = true/*re-enable userinteractions*/
        }
    }
}
