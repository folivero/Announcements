import Foundation

final class PersonListModel {
    private let announcer = Announcer<PersonListAnnouncement>()
    let listener: AnnouncerListener<PersonListAnnouncement>
    let models: [PersonViewModel]
    private(set) var selectedIndex: Int

    init(selectedIndex: Int, models: [PersonViewModel]) {
        self.selectedIndex = selectedIndex
        self.models = models
        self.listener = AnnouncerListener(announcer: announcer)
    }

    var selectedPerson: PersonViewModel? {
        return models[selectedIndex]
    }

    func select(at: Int) {
        selectedIndex = at
        announcer.announce(ann: .selectionChanged)
    }
}

extension PersonListModel {
    static var `default`: PersonListModel {
        return PersonListModel(
            selectedIndex: 0,
            models: [
                PersonViewModel(name: "Messi", country: "Argentina", age: "30"),
                PersonViewModel(name: "Iniesta", country: "Spain", age: "33"),
                PersonViewModel(name: "Suarez", country: "Uruguay", age: "31"),
                PersonViewModel(name: "Rakitic", country: "Croatia", age: "29"),
            ]
        )
    }
}
