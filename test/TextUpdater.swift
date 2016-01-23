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
        let defineWord: (String, String? -> ()) -> ()
    }
    
    struct Presenters {
        let text: Presenter<String>
        let textUpdate: Presenter<String -> ()>
    }
    
    static func ViewModel(services: Services, _ presenters: Presenters) {
        presenters.text.present("")
        
        presenters.textUpdate.present { newText in
            services.defineWord(newText) { definition in
                presenters.text.present(definition ?? "unknown")
            }
        }
    }
}

class TextUpdaterViewController: UIViewController {
    @IBOutlet weak var label: UILabel!
    @IBOutlet weak var textField: UITextField!
    
    var viewModel: TextUpdater.UnpresentedViewModel?
    
    override func viewDidLoad() {
        viewModel?(TextUpdater.Presenters(
            text: self.label.textPresenter,
            textUpdate: self.textField.textSinkPresenter)
        )
    }

}