import UIKit
import RxSwift

extension UILabel {
    
    var textPresenter: Presenter<String> {
        return Presenter.UI { [weak self] in
            self?.text = $0
            return NopDisposable.instance
        }
    }
}

extension UITextField {
    
    var textSinkPresenter: Presenter<String -> ()> {
        return Presenter.UI { sink in
            let textDidChangeObserver = NSNotificationCenter
                .defaultCenter()
                .addObserverForName(UITextFieldTextDidChangeNotification,
                    object: self,
                    queue: NSOperationQueue.mainQueue(),
                    usingBlock: { [weak self] _ in
                        if let text = self?.text {
                            sink(text)
                        }
                    })
            
            return AnonymousDisposable {
                NSNotificationCenter
                    .defaultCenter()
                    .removeObserver(textDidChangeObserver)
            }
        }
    }
}