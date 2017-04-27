# UVSearchBar

## Description
`UVSearchBar` is an `UISearchBar` subclass that gains all it's features except its also customizable.
It uses `UVSearchBarPresentable` protocol conforming objects to get it's view parameters without a wall of boilerplate code in a very gentle way.
It also kinda supports `@IBInspectable` and `@IBDesignable`

Please note that this little library was done for internal use in one project and this is why its not adapted for public use well (lacking docs, etc.).
It was also tested only in my internal project environment and may have glitches in other usages. If you'll get in such a situation, feel free to contact me here on GitHub or create a pull request.

## Usage

### Installation
Copy files from `UVSearchBar` folder to your project.

### Initialization
To create an UVSearchViewController use `init(searchResultsController:searchBarFrame:searchViewModel:)` constructor.

```
// Create a search controller with a search bar of given frame
// (use searchTextFieldEdgeInsets of UVSearchBarPresentable protocol
// to customize search text field's frame based on the frame given here)
searchController = UVSearchController(searchResultsController: nil, searchBarFrame: searchView.bounds,
                searchBarViewModel: DefaultSearchBarModel())
```

### Customization
```
// Note that you shouldn't use default delegate and searchBar properties and use custom ones instead
searchController.sourceController = self
searchController.customSearchBar.placeholder = "Поиск города..."
searchController.customDelegate = self

// add search controller's search bar to the containing view you want
searchView.addSubview(searchController.customSearchBar)

// customize default UISearchController's properties!
searchController.hidesNavigationBarDuringPresentation = true



