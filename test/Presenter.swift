import Foundation
import RxSwift

struct Presenter<T> {
    
    private let bind: T -> Disposable
    
    func present(value: T) -> Disposable {
        return bind(value)
    }
    
    private init(_ bind: T -> Disposable) {
        self.bind = bind
    }
}

extension Presenter {
    
    static func UI(bind: T -> Disposable) -> Presenter {
        return Presenter { viewModel in
            return MainScheduler.instance.schedule(viewModel, action: bind)
        }
    }
}