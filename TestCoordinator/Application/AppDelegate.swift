import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    private lazy var container = Container()
    private var appCoordinator: Coordinator?

    var window: UIWindow?
    
    func application(
        _ application: UIApplication,
        didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil
    ) -> Bool {
        runUI()
        return true
    }
    
    private func runUI() {
        let (window, coordinator) = container.appFactory.makeKeyWindowWithCoordinator()
        self.window = window
        self.appCoordinator = coordinator
        
        window.makeKeyAndVisible()
//        coordinator.start(step: DeeplinkStep.profile)
        coordinator.start(step: AppStep.main)
    }
}
