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
        self.view.isUserInteractionEnabled = false/*disable userinteractions*/
        if curView.frame.origin.x < leftBoundry {/*more 25% to the left*/
            beyondLeft()
        }else if (curView.frame.origin.x + curView.frame.width) > rightBoundry {/*more than 25% to the right*/
            beyondRight()
        }else {/*released within boundries*/
            withinBoundry()
        }
        self.view.layoutIfNeeded()
    }
    /**
     * When user drags a tap across the screen
     */
    @objc func handlePan(recognizer:UIPanGestureRecognizer) {
        let translation = recognizer.translation(in: self.view)
//        Swift.print("translation:  \(translation)")
        let xConstraint:NSLayoutConstraint = {
            guard let posConstraint = curView.anchor else {fatalError("err posConstraint not available")}
            let x = posConstraint.x.constant + translation.x
            NSLayoutConstraint.deactivate([posConstraint.x])
            return Constraint.anchor(curView, to: self.view, align: .left, alignTo: .left, offset: x)
        }()
        NSLayoutConstraint.activate([xConstraint/*,pos.y*/])
        curView.anchor?.x = xConstraint
        self.view.layoutIfNeeded()/*visual update*/
        /**/
        recognizer.setTranslation(.zero, in: self.view)/*reset recognizer*/
        if [.ended,.cancelled,.failed].contains(recognizer.state)   {
            onTapRelease()/*call tapRelease*/
        }
    }
}
/**
 * Cases
 */
extension VC{
    /**
     * Handle paning beyond the left boundry
     * NOTE: basically swipe right to left, where the left side page disapears
     */
    fileprivate func beyondLeft(){
        Swift.print("outside left boundry")
        let screenRect = UIScreen.main.bounds
        let to:CGFloat = screenRect.origin.x - screenRect.width
        self.animate(to: to) { /*onComplete closure*/
            Swift.print("swap the views around 🎉")
            self.curIdx += 1/*progress the index by 1*/
            self.leftView.removeFromSuperview()/*leftView is now removed as its completly sight*/
            /**/
            self.leftView = self.curView /*curView now becomes leftView*/
            if let anchor = self.leftView.anchor, let size = self.leftView.size {
                NSLayoutConstraint.deactivate([anchor.x,anchor.y,size.w,size.h])
            }
            self.curView = self.rightView/*rightView now becomes curView */
            if let anchor = self.curView.anchor, let size = self.curView.size {
                NSLayoutConstraint.deactivate([anchor.x,anchor.y,size.w,size.h])
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
     */
    fileprivate func beyondRight(){
        Swift.print("outside right boundry")
        let screenRect = UIScreen.main.bounds
        let to:CGFloat = screenRect.origin.x + screenRect.width
        animate(to:to){/*onComplete closure*/
            Swift.print("Swap the views around 👌")
            self.curIdx -= 1
            self.rightView.removeFromSuperview()
            /**/
            self.rightView = self.curView/*the prev page is now cur page*/
            if let anchor = self.rightView.anchor, let size = self.rightView.size {
                NSLayoutConstraint.deactivate([anchor.x,anchor.y,size.w,size.h])
            }
            self.curView = self.leftView
            if let anchor = self.curView.anchor, let size = self.curView.size {
                NSLayoutConstraint.deactivate([anchor.x,anchor.y,size.w,size.h])
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
    fileprivate func withinBoundry(){
        Swift.print("within boundries")
        let screenRect = UIScreen.main.bounds
        let to:CGFloat = screenRect.origin.x
        animate(to:to){/*onComplete closure*/
            Swift.print("swap the views around ✅")
            self.view.isUserInteractionEnabled = true/*re-enable userinteractions*/
        }
    }
}
