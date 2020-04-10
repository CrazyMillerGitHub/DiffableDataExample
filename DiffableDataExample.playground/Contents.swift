import UIKit
import PlaygroundSupport

// MARK: Section inizialize
// (String to use rawValue and CaseIterable to work like a sequence)

enum Section: String, CaseIterable {
    case bestFriend = "Best friend"
    case schoolFriend = "School friend"
    case family = "Family"
}

struct Person: Hashable, Equatable {

    let identifier: UUID = UUID()

    let firstName: String
    let lastName: String
    let age: Int

    static func == (lhs: Person, rhs: Person) -> Bool {
        return lhs.identifier == rhs.identifier
    }
}

struct ClosePeople {

    let bestFriend: [Person]
    let schoolFriend: [Person]
    let family: [Person]

    init(_ bestFriend: [Person] = [],
         _ schoolFriend: [Person] = [],
         _ family: [Person] = []) {
        self.bestFriend = bestFriend
        self.schoolFriend = schoolFriend
        self.family = family
    }
}

// MARK: CustomStringConvertible
// print(Person())
extension Person: CustomStringConvertible {

    var description: String {
        return """
        First name: \(firstName);
        Last name: \(lastName);
        Age: \(age).
        """
    }
}

// MARK: - Builder
// Builder pattern to work with closures when we want to create ui element

protocol Builder {}

extension NSObject: Builder {}

extension Builder {
    func with(config: (Self) -> Void ) -> Self {
        config(self)
        return self
    }
}

// MARK: - DataSource
class DataSource: UITableViewDiffableDataSource<Section, Person> {

    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return Section.allCases[section].rawValue.uppercased()
    }

}

// MARK: - TablewViewController
class TablewViewController: UIViewController {

    // fill random data that we will load in the future
    let list = ClosePeople([Person(firstName: "Mary", lastName: "Jane", age: 18),
                            Person(firstName: "Tom", lastName: "Soyer", age: 18)],
                           [Person(firstName: "Alex", lastName: "Kolom", age: 19)],
                           [Person(firstName: "Tatiana", lastName: "Udar", age: 46)])


    private let reusableIdentifier = String(describing: self)

    private lazy var tableView = UITableView(frame: .zero, style: .insetGrouped).with { (tableView) in
        // disable default constraints
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.backgroundColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 0)
    }

    /* ВataSource that we will use in the future
     makeDataSource method will be executed, when we first time create
     a property.
     */
    private lazy var dataSource = makeDataSource()

    override func loadView() {
        super.loadView()
        tableView.delegate = self
        // reigster a cell
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: reusableIdentifier)
        // add tableview as a sabview to view (before constraint init)
        view.addSubview(tableView)

    }

    override func viewDidLoad() {
        super.viewDidLoad()
        //
        performConstraint()
        // update values for TableView
        update(with: list)
    }

    /// create data source
    /// - Returns: Data Source
    private func makeDataSource() -> DataSource {

        let reusableIdentifier = self.reusableIdentifier

        return DataSource(tableView: tableView) { tableView, IndexPath, person in
            let cell = tableView.dequeueReusableCell(withIdentifier: reusableIdentifier,
                                                     for: IndexPath)
            cell.textLabel?.text = person.firstName
            cell.textLabel?.font = UIFont.systemFont(ofSize: 17, weight: .medium)
            cell.detailTextLabel?.text = "\(person.lastName) + \(person.age)"
            cell.textLabel?.textColor = .white
            cell.backgroundColor = .black
            return cell
        }
    }

}

// MARK: - TableView Delegate
extension TablewViewController: UITableViewDelegate {

    func update(with list: ClosePeople, animate: Bool = true) {

        var snapshot = NSDiffableDataSourceSnapshot<Section, Person>()
        snapshot.appendSections(Section.allCases)

        snapshot.appendItems(list.bestFriend, toSection: .bestFriend)
        snapshot.appendItems(list.family, toSection: .family)
        snapshot.appendItems(list.schoolFriend, toSection: .schoolFriend)

        dataSource.apply(snapshot, animatingDifferences: animate)
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let person = dataSource.itemIdentifier(for: indexPath) {
            var currentSnapshot = dataSource.snapshot()
            currentSnapshot.deleteItems([person])

            dataSource.apply(currentSnapshot)
        }
    }

}

// MARK: - Constraint init
extension TablewViewController {

    private func performConstraint() {
        NSLayoutConstraint.activate([
            tableView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }
}

PlaygroundPage.current.liveView = UINavigationController(rootViewController: TablewViewController())
