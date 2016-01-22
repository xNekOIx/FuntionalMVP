import UIKit

public enum TextUpdater {
    
    struct ViewModelPresenter {
        let text: Presenter<String>
        let input: Presenter<String -> ()>
    }
    
    @objc(TextUpdaterViewController)
    public class ViewController: UIViewController {
        
        @IBOutlet weak var label: UILabel!
        @IBOutlet weak var textField: UITextField!
        
        var viewModel: ((() -> ViewModelPresenter) -> ())?
        
        override public func viewDidLoad() {
            super.viewDidLoad()
            
            viewModel! {[unowned self] in
                return ViewModelPresenter(
                    text: self.label.textPresenter,
                    input:  self.textField.textSinkPresenter) }
        }
    }
}