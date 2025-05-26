# DiffableDataExample

A comprehensive iOS Swift Playground demonstrating the implementation of `UITableViewDiffableDataSource` for modern table view data management with smooth animations.

## 📱 Overview

This project showcases how to use iOS 13+ `UITableViewDiffableDataSource` to create efficient, animated table views that automatically handle data changes. The example implements a contact management interface with categorized sections and demonstrates best practices for diffable data sources.

## ✨ Features

- **Modern Data Source**: Uses `UITableViewDiffableDataSource` instead of traditional delegate methods
- **Automatic Animations**: Smooth insert, delete, and move animations without manual implementation
- **Sectioned Data**: Demonstrates multiple sections (Best Friends, School Friends, Family)
- **Interactive Demo**: Tap rows to delete items with animated transitions
- **Clean Architecture**: Implements proper separation of concerns with custom data source
- **Builder Pattern**: Includes a reusable builder pattern for UI component configuration

## 🏗 Architecture

### Core Components

- **`Section`**: An enum defining table view sections with string raw values
- **`Person`**: A `Hashable` model representing individual contacts
- **`ClosePeople`**: A data structure organizing people into categories
- **`DataSource`**: A custom `UITableViewDiffableDataSource` subclass
- **`TablewViewController`**: The main view controller managing the table view

### Key Concepts Demonstrated

1. **Diffable Data Source Setup**: How to configure and initialize a diffable data source
2. **Snapshot Management**: Creating and applying snapshots for data updates
3. **Section Headers**: Custom section header implementation
4. **Interactive Updates**: Handling user interactions with automatic data source updates
5. **Animation Control**: Managing animation states during updates

## 🚀 Getting Started

### Prerequisites

- **Xcode 11.0+** (for iOS 13+ features)
- **iOS 13.0+** deployment target
- **Swift 5.0+**

### Running the Example

1. Clone the repository:
   ```bash
   git clone https://github.com/yourusername/DiffableDataExample.git
   cd DiffableDataExample
   ```

2. Open the playground:
   ```bash
   open DiffableDataExample.playground
   ```

3. Run the playground in Xcode to see the interactive demo

## 💡 Usage Example

Here's how the diffable data source is configured:

```swift
// Create a snapshot
var snapshot = NSDiffableDataSourceSnapshot<Section, Person>()
snapshot.appendSections(Section.allCases)

// Add items to sections
snapshot.appendItems(list.bestFriend, toSection: .bestFriend)
snapshot.appendItems(list.family, toSection: .family)
snapshot.appendItems(list.schoolFriend, toSection: .schoolFriend)

// Apply changes with animation
dataSource.apply(snapshot, animatingDifferences: true)
```

## 🎯 Key Learning Points

- **Type Safety**: Using generic types for sections and items
- **Hashable Conformance**: Implementing proper `Hashable` protocol for model objects
- **Snapshot-Based Updates**: Understanding how snapshots represent table view state
- **Performance**: Efficient diffing algorithms for large datasets
- **Animation Customization**: Controlling when and how animations occur

## 🔧 Customization

The example can be easily modified to:

- Add more section types by extending the `Section` enum
- Include additional person properties in the `Person` struct
- Customize cell appearance in the data source configuration
- Implement different interaction patterns (editing, reordering, etc.)

## 📖 Documentation

For more information about diffable data sources, see:

- [Apple's UITableViewDiffableDataSource Documentation](https://developer.apple.com/documentation/uikit/uitableviewdiffabledatasource)
- [WWDC 2019: Advances in UI Data Sources](https://developer.apple.com/videos/play/wwdc2019/220/)

## 📄 License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.