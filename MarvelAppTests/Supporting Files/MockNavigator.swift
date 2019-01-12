import UIKit
@testable import MarvelApp

final class MockNavigator: MarvelApp.Navigator {
    var pushedViewController: ((UIViewController) -> Void)?
    
    func pushViewController(_ viewController: UIViewController, animated: Bool) {
        pushedViewController?(viewController)
    }
}
