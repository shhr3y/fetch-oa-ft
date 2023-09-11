# Fetch OA FT App

# Description
iOS App to display desserts from [themealdb.com](https://themealdb.com)

# Getting Started
1. The app is compatible with the latest XCode
2. Download the project files from the repository `git clone https://github.com/shhr3y/fetch-oa-ft.git`
3. Open the project files in XCode
4. Run the active scheme

# Architecture
Project is implemented using the Model-View-Controller (MVC) architecture.
### Data Flow
- Navigation screen (main) displays items alphabetically from endpoint `https://themealdb.com/api/json/v1/1/filter.php?c=Dessert`
- When user navigates to the item details screen, program attempts to retrieve details from endpoint `https://themealdb.com/api/json/v1/1/lookup.php?i=<idMeal>`
- item images are stored in cache if not previously present.
### Structure
```
- Model
- View
- Controller
- Service
- Extensions
```
- Model: Files to structure item data
- Views: Files of type view
- Controller: Files of type view controller
- Service: Files to fetch data from network endpoints
- Extension: Files adding helper functions as extensions

### Running Tests
The app can be tested using the built-in framework XCTest. Tests have been created and can be run from `fetch_oaTests.swift`
- testBuildFilterUrl
- testBuildFilterDessertsUrl
- testBuildLookupDessertDetailUrl
- testFilterDesserts
- testLookupDessertDetail
  
### API

[TheMealDB](https://themealdb.com/api)
