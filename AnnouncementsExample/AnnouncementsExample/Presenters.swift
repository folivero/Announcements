import Foundation
import UIKit

enum PersonListAnnouncement: Hashable {
    case selectionChanged
}

enum SegmentedControllerAnnouncement: Hashable {
    case selectionChanged
}

struct PersonViewPresenter {
    init(listModel: PersonListModel, personView: PersonView) {
        listModel.listener.when(ann: .selectionChanged) { ann in
            switch ann {
            case .selectionChanged:
                personView.configure(person: listModel.selectedPerson!)
            }
        }
    }
}

struct PersonListPresenter {
    private let wrapper: UIControlWrapper<SegmentedControllerAnnouncement, UISegmentedControl>

    init(listModel: PersonListModel, segmentedControl: UISegmentedControl) {
        wrapper = UIControlWrapper(control: segmentedControl, event: .valueChanged, announcement: .selectionChanged)
        wrapper.listener.when(ann: .selectionChanged) { [weak listModel, weak segmentedControl] _ in
            let selectedIndex = segmentedControl?.selectedSegmentIndex ?? 0
            listModel?.select(at: selectedIndex)
        }
        listModel.listener.when(ann: .selectionChanged) { _ in
            segmentedControl.selectedSegmentIndex = listModel.selectedIndex
        }
        segmentedControl.removeAllSegments()
        listModel.models.enumerated().forEach { offset, model in
            segmentedControl.insertSegment(withTitle: model.name, at: offset, animated: false)
        }
    }
}


final class UIControlWrapper<A: Hashable, C: UIControl> {
    let control: C
    private let announcer = Announcer<A>()
    let listener: AnnouncerListener<A>
    let announcement: A

    init(control: C, event: UIControl.Event, announcement: A) {
        self.control = control
        self.announcement = announcement
        self.listener = AnnouncerListener(announcer: announcer)
        control.addTarget(self, action: #selector(handleEvent), for: event)
    }

    @objc func handleEvent() {
        announcer.announce(ann: announcement)
    }
}
