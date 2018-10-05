import UIKit

class PersonView: UIView {
    @IBOutlet private var nameLabel: UILabel!
    @IBOutlet private var countryLabel: UILabel!
    @IBOutlet private var ageLabel: UILabel!

    func configure(person: PersonViewModel) {
        self.nameLabel.text = person.name
        self.countryLabel.text = person.country
        self.ageLabel.text = person.age
    }
}
