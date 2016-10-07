# Listen
Simple communication between UIViewControllers / Objects

# Why? NSNotificatonCenter works just fine.
- Easier to understand syntax
- Can send messages to one instance, an certain type of object, or all objects
- When listening for messages, you will always know the **source** of the message (who "said" it)
- Unlike NSNotificationCenter, forgetting to remove observers will not cause an entire object from deallocating (my biggest complaint with NSNotificationCenter)

# Installation
Add *DataListener.swift* and *Listenable.swift* to your project.

# Usage
Conform to the *Listenable* protocol on the object you want to be able to send / recieve messages.
```swift
class ViewController: UIViewController, Listenable{
  //...class implementation
}
```

### You can send messages to every object that has adopted *Listenable*, every object of a of a certain type, or a particular instance of an object.

## Send a message to every *Listenable*
```swift
speak("General", command:"Log", message:json) //json is really anything of type [String:AnyObject]? <--optional
```

## Send a message to every *Listenable* of a certain type (notice the function name is now "speakTo" instead of "speak")
```swift
speakTo("LoginViewController", messageType: "General", command: "DoSomething", message: nil)
```
The "type" your sending to here is the class name of the object (e.g. "LoginViewController").

## Send a message to a particular instance
```swift
let secondViewController = SecondViewController() //just for example
speakTo(secondViewController, messageType: "General", command: "Log", message: ["data":"print this out"])
```

**Now you must listen for the messages**

Listen's closure always passes in the arguments for speaker (String?), speakerAddr (String?), message ([String:AnyObject]?).
They are all optional so you can simply ignore them all or only one's you don't need (e.g. _, _, json in...).

This way, even when you are listening for general messages, **you can still tell who sent it**. :)

## Listen for a message from every *Listenable*
```swift
listen("Authentication", command: "Authentication.Changed") { _ in
    //listening for a message in group "Authentication" with command "Authentication.Changed"
    //also, notice, we are not expecting a message nor do we care about the speaker so we can simply write "_"
    //    for the parameters of the closure
}
```

## Listen for a message from every *Listenable* of a certain type (again, notice the function name is now "listenTo" instead of "listen")
```swift
listenTo("LoginViewController", messageType:"Authentication", command: "Authentication.Changed") { _ in
    //listening for an authentication changed message from the LoginViewController
}
```
One nice by product of listening to an instance by type is that you can set up a listener for an object before you've even instaniated it...

## Example
*SettingsViewController* could add a listener for *NameChangeViewController* (e.g. listenTo("NameChangeViewController...)).  Now when you change your name, you can speakTo("SettingsViewController"... and pass back the new *name*.

## Listen for a message from a particular instance
```swift
listenTo(DataLayer.sharedInstance, messageType:"General", command: "Print"){ (speaker, speakerAddr, json) in
    if json != nil{
        print(json!["realMessage"] as! String)
        print("Sincerly,")
        print("\(speaker!)(\(speakerAddr!))")
    }
}
```

## Stop listening to particular messageType and command from a particular instance
```swift

```

## Stop listening to particular messageType and command from a certain type
```swift

```

## Stop listening to particular messageType and command from every *Listenable*
```swift

```

## Stop listening for all messages from a particular instance
```swift

```

## Stop listening for all messages from a certain type
```swift

```

## Stop listening for ALL messages
```swift

```

### Lastly
## Performing an action and then listening
Since I was tired of writing code like this...
```swift
getNewData()
listen("Data", command: "Update") { _ in
    getNewData()
}
```
...I decided to write a doListen function (named after a "do-while" loop).
```swift
doListen("Data", command: "Update") { _ in
    getNewData()
}
```
This code will perform *getNewData()* once and then listen for the *Update* command before it runs again. *doListen* also has the usual *doListenTo* counterparts.

## TODOs
- [ ] Swift 3 support

## Authors

Andrew Goodwin, andrewggoodwin@gmail.com

## License

Listen is available under the MIT LICENSE. See the LICENSE file for more info.


