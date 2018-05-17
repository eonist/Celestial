import UIKit

extension VC{
    /**
     * Normal tap
     */
    @objc func handleTap(sender : UITapGestureRecognizer) {
        Swift.print("handleTap")
        if sender.state == .ended || sender.state == .cancelled || sender.state == .failed  {
            onTapRelease()
        }//tap release
    }
    /**
     * When user drags a tap across the screen
     */
    @objc func handlePan(recognizer:UIPanGestureRecognizer) {
        let translation = recognizer.translation(in: self.view)
        Swift.print("translation:  \(translation)")
        guard let posConstraint = curView.anchor else {fatalError("err posConstraint not available")}
        let x = posConstraint.x.constant + translation.x
        NSLayoutConstraint.deactivate([posConstraint.x])
        let xConstraint = Constraint.anchor(curView, to: self.view, align: .left, alignTo: .left, offset: x)
        NSLayoutConstraint.activate([xConstraint/*,pos.y*/])
        curView.anchor?.x = xConstraint
        self.view.layoutIfNeeded()
        
        recognizer.setTranslation(CGPoint.zero, in: self.view)//reset recognizer
        if recognizer.state == .ended || recognizer.state == .cancelled || recognizer.state == .failed  {
            onTapRelease()
        }//tap release
    }
    /**
     * When user release tap (regular tap, or drag tap)
     */
    private func onTapRelease(){
        Swift.print("onTapRelease()")
        let screenRect = UIScreen.main.bounds
        var leftBoundry:CGFloat {return screenRect.origin.x - screenRect.size.width/4 }
        var rightBoundry:CGFloat {return screenRect.size.width + screenRect.size.width / 4 }
        self.view.isUserInteractionEnabled = false//disable userinteractions
        if curView.frame.origin.x < leftBoundry {//more 25% to the left
            outsideLeftBoundry()
        }else if (curView.frame.origin.x + curView.frame.width) > rightBoundry {//more than 25% to the right
            outsideRightBoundry()
        }else {//released within boundries
            withinBoundry()
        }
        self.view.layoutIfNeeded()
    }
}

extension VC{
    /**
     * outsideLeftBoundry
     */
    fileprivate func outsideLeftBoundry(){
        Swift.print("outside left boundry")
        let screenRect = UIScreen.main.bounds
        let to:CGFloat = screenRect.origin.x - screenRect.width
        animate(to: to) {
            Swift.print("swap the views around 🎉")
            self.curIdx += 1
            self.leftView.removeFromSuperview()
            //
            self.leftView = self.curView
            if let pos = self.leftView.anchor, let size = self.leftView.size {
                NSLayoutConstraint.deactivate([pos.x,pos.y,size.w,size.h])
            }
            self.curView = self.rightView
            if let pos = self.curView.anchor, let size = self.curView.size {
                NSLayoutConstraint.deactivate([pos.x,pos.y,size.w,size.h])
            }
            self.setCenterConstraints(self.curView)
            self.setLeftConstraints(self.leftView)
            //
            let newRightIdx = IntParser.normalize(self.curIdx + 1, VC.citiesAndColors.count) //loopy index
            self.rightView = self.createRightView(idx: newRightIdx)
            let normalizedCurIdx = IntParser.normalize(self.curIdx, VC.citiesAndColors.count) //loopy index
            self.footer.updateWeather(idx: normalizedCurIdx)
            self.view.isUserInteractionEnabled = true//enable userinteractions
        }
    }
    /**
     * outsideRightBoundry
     */
    fileprivate func outsideRightBoundry(){
        Swift.print("outside right boundry")
        let screenRect = UIScreen.main.bounds
        let to:CGFloat = screenRect.origin.x + screenRect.width
        animate(to:to){
            Swift.print("swap the views around 👌")
            self.curIdx -= 1
            self.rightView.removeFromSuperview()
            //
            self.rightView = self.curView
            if let pos = self.rightView.anchor, let size = self.rightView.size {
                NSLayoutConstraint.deactivate([pos.x,pos.y,size.w,size.h])
            }
            self.curView = self.leftView
            if let pos = self.curView.anchor, let size = self.curView.size {
                NSLayoutConstraint.deactivate([pos.x,pos.y,size.w,size.h])
            }
            self.setCenterConstraints(self.curView)
            self.setRightConstraints(self.rightView)
            //
            let newLeftIdx = IntParser.normalize(self.curIdx - 1, VC.citiesAndColors.count) //loopy index
            self.leftView = self.createLeftView(idx: newLeftIdx)
            let normalizedCurIdx = IntParser.normalize(self.curIdx, VC.citiesAndColors.count) //loopy index
            self.footer.updateWeather(idx: normalizedCurIdx)
            self.view.isUserInteractionEnabled = true//enable userinteractions
        }
    }
    /**
     * withinBoundry
     */
    fileprivate func withinBoundry(){
        Swift.print("within boundries")
        let screenRect = UIScreen.main.bounds
        let to:CGFloat = screenRect.origin.x
        animate(to:to){
            Swift.print("swap the views around ✅")
            self.view.isUserInteractionEnabled = true//enable userinteractions
        }
    }
}
