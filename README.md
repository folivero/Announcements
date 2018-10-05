# Announcements
An implementation of Announcements in swift. 

Announcements promote the use of first class objects when using the Observer mechanism, a more expressive publish/subscribe mechanism than using plain strings, they originally come from the Smalltalk programming language.

## Example

The example makes use the "Presenter First" approach (see [atomic_object](https://atomicobject.com/resources/presenter-first)) that promotes presenters (the **P** in MV**P**) to a principal role, when tackling the design and implementation of an applications view layer.

The app is an simple person list, with a built-in chooser implemented via a segemented control, to showcase the use of Announcements as a means to syncrhonize between models and views via a mediator, i.e: PersonListPresenter and PersonViewPresenter.

Note: we use a wrapper around UIControl, to adapt the addTarget:action:for: style to when:do:

In the view controller we initialise the presenters (first)
```swift
 override func viewDidLoad() {
        super.viewDidLoad()
        listPresenter = PersonListPresenter(listModel: personList, segmentedControl: segmentedControl)
        viewPresenter = PersonViewPresenter(listModel: personList, personView: personView)
    }
 ```
 where each presenter stitches the model and the view using the when:do style as follows 
```swift 
        listModel.listener.when(ann: .selectionChanged) { ann in
            switch ann {
            case .selectionChanged:
                personView.configure(person: listModel.selectedPerson!)
            }
        }
 ```
and annoucements will eventually get triggered whenever we change the list model:
```swift 
  func select(at: Int) {
        selectedIndex = at
        announcer.announce(ann: .selectionChanged)
    } 
``` 
