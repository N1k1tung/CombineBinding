# CombineBinding

Streamlines bindings between view and viewModel, makes them more concise and readable

**Before**

```swift
    loginButton.tapped
        .sink(vm.loginTapped)
        .stored(in: &cancellables)
    emailButton.tapped
        .sink(vm.emailTapped)
        .stored(in: &cancellables)    
    tableView.modelSelected
        .sink { [weak self] _ in self?.tableView.reloadData() }
        .stored(in: &cancellables)
    someButton.tapped
        .subscribe(vm.someSubject)
        .stored(in: &cancellables)
 }
```


**After**

```swift
 bind {
    loginButton.tapped ~> vm.loginTapped
    emailButton.tapped ~> vm.emailTapped
    tableView.modelSelected ~> { [weak self] _ in self?.tableView.reloadData() }
    someButton.tapped ~> vm.someSubject
 }
```
