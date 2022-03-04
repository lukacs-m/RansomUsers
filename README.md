# Random Users

Random Users is a little project to showcase a few different concepts and coding practices.

## What
- [x] No storyboards
- [x] CLean archi with MVVM
- [x] Uses latest Apple's [Combine](https://developer.apple.com/documentation/combine)
- [x] Some Dependency injeftion

## Getting Started

* [Packages](#packages)
* [Architecture](#architecture)
* [Testing](#testing)


### Packages

- `Snapkit` for ui programming
- `Resolver` for Dependency injection
- `SWEDImage` for async image loading

### Architecture

The project in constructed around a clean archi MVVM design.

- The presentation layer can be found in the `Scenes` folder
- The domain layer regroups the `Repositories` and the `UseCases`
- The data layer is composed of several service and tools

Everything is link through DI and protocols for loose linkage between elements

### Testing

You can find a few test examples using DI resolver mocking system.
This is not a exaustive test implementation but it covers some importante element of the project
