import Foundation

final class Disposable {
    let completion: () -> ()

    init(completion: @escaping () -> ()) {
        self.completion = completion
    }

    func invalidate() {
        completion()
    }

    deinit {
        completion()
    }
}

final class Announcer<Announcement: Hashable> {
    typealias Handler = (Announcement) -> ()
    private var allObservations: [UUID: Handler] = [:]
    private var observations: [Announcement: [UUID: Handler]] = [:]

    func add(observer: AnyObject, handler: @escaping Handler) -> Disposable {
        let id = UUID()
        allObservations[id] = handler
        return Disposable { [weak self] in
            self?.allObservations.removeValue(forKey: id)
        }
    }

    func add(observer: AnyObject, on ann: Announcement, handler: @escaping Handler) -> Disposable {
        let id = UUID()
        observations[ann, default: [:]][id] = handler
        return Disposable { [weak self] in
            self?.observations[ann]?.removeValue(forKey: id)
        }
    }

    func announce(ann: Announcement) {
        allObservations.values.forEach { $0(ann) }
        observations[ann]?.values.forEach { $0(ann) }
    }
}

final class AnnouncerListener<Announcement: Hashable> {
    private let announcer: Announcer<Announcement>
    private var disposables: [Disposable] = []

    init(announcer: Announcer<Announcement>) {
        self.announcer = announcer
    }

    func when(ann: Announcement, do callback: @escaping (Announcement) -> ()) {
        let disposable = announcer.add(observer: self, on: ann, handler: callback)
        disposables.append(disposable)
    }
}
