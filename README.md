# MGSwiftRouter

General routing, through which we can access our module entrance, and pass the information to the entrance function through the way of parameters, and then forward the task through the entrance function, so as to realize various functions.
Through the above way, we can achieve a series of functions such as page Jump, function call and so on through routing

## Example

To run the example project, clone the repo, and run `pod install` from the Example directory first.

### code
1>、For our module, we need to provide a entrance service first, it needs to conform the protocol of MGServiceEntry
~~~
class UserServiceEntry: MGServiceEntry {
    ...
}
~~~

2>、Register the route with following code
~~~
import MGSwiftRouter
...
  router.register(clsTarget: UserServiceEntry.self)
  // or
  router.register(uri: "test://log/log", clsTarget: LogServiceEntry.self)
...
~~~

3>、Call code
~~~
    // Calling service through the URI
    // router.router("test://log/log?string=hellobaby")    // Do not receive return value
    router.router("test://log/log?string=hellobaby") { (params) in
        guard let params = params as? String else {
            return
        }
        
        print(params)
    }
~~~

## Requirements

## Installation

MGSwiftRouter is available through [CocoaPods](https://cocoapods.org). To install
it, simply add the following line to your Podfile:

pod 'MGSwiftRouter'

## Author

mszdream, mszdream@126.com

## License

MGSwiftRouter is available under the MIT license. See the LICENSE file for more info.
