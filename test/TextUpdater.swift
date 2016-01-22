import UIKit

protocol ViewModel {
    typealias Services
    typealias Presenters
    
    static func ViewModel(services: Services, _ presenters: Presenters);
}

extension ViewModel {
    typealias UnpresentedViewModel = Presenters -> ()
    static func ViewModel(services: Services)(presenters: Presenters) {
        ViewModel(services, presenters)
    }
}

enum TextUpdater : ViewModel {
    struct Services {
        let reversText: String -> String
    }
    
    struct Presenters {
        let presentText: String -> ()
        let presentTextUpdate: (String -> ()) -> ()
    }
    
    static func ViewModel(services: Services, _ presenters: Presenters) {
        presenters.presentText("")
        
        presenters.presentTextUpdate { newText in
            presenters.presentText(services.reversText(newText))
        }
    }
}

class TextUpdaterViewController: UIViewController {
    @IBOutlet weak var label: UILabel!
    @IBOutlet weak var textField: UITextField!
    
    var viewModel: TextUpdater.UnpresentedViewModel?
    
    override func viewDidLoad() {
        viewModel?(TextUpdater.Presenters(
            presentText: {[weak self] newText in
                self?.label.text = newText
            },
            presentTextUpdate: {[weak self] textSink in
                self?.textSink = textSink
            })
        )
    }
    
    var textSink : (String -> ())?
    @IBAction func updateText() {
        textSink?(textField.text ?? "")
    }
}