import UIKit

func initialViewModel(service: NSURLSession) -> (() -> TextUpdater.ViewModelPresenter) -> () {
    return { vmp in
        let vmpresenter = vmp()
        vmpresenter.input.present { vmpresenter.text.present($0) }
    }
}

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        
        let vc = UIStoryboard(name: "Main", bundle: nil).instantiateInitialViewController() as! TextUpdater.ViewController
        
        window!.rootViewController = vc
        vc.viewModel = initialViewModel(NSURLSession.sharedSession())
        
        return true
    }
}

