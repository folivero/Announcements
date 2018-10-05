import UIKit

class ViewController: UIViewController {
    @IBOutlet var personView: PersonView!
    @IBOutlet var segmentedControl: UISegmentedControl!

    let personList = PersonListModel.default
    var listPresenter: PersonListPresenter?
    var viewPresenter: PersonViewPresenter?

    override func viewDidLoad() {
        super.viewDidLoad()
        listPresenter = PersonListPresenter(listModel: personList, segmentedControl: segmentedControl)
        viewPresenter = PersonViewPresenter(listModel: personList, personView: personView)
        personList.select(at: 0)
    }
}

struct Person {
    let name: String
    let country: String
    let age: Int
}

struct PersonViewModel {
    let name: String
    let country: String
    let age: String
}
