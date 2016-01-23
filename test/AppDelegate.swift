import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        
        let vc = UIStoryboard(name: "Main", bundle: nil).instantiateInitialViewController() as! TextUpdaterViewController
        
        window!.rootViewController = vc
        
        vc.viewModel = TextUpdater.ViewModel(TextUpdater.Services.init(
            defineWord: APIService.requestDefinitions)
        )
        
        return true
    }
}

