# Listen
Simple communication between UIViewControllers / Objects

#Installation
Add *DataListener.swift* and *Listenable.swift* to your project.

#Usage
Conform to the *Listenable* protocol on the object you want to be able to send / recieve messages.
```swift
class ViewController: UIViewController, Listenable{
  //...class implementation
}
```

###You can send messages to every object that has adopted *Listenable*, every object of a of a certain type, or a particular instance of an object.

##Send a message to every *Listenable*
```swift
speak("General", command:"Log", message:json) //json is really anything of type [String:AnyObject]? <--optional
```

##Send a message to every *Listenable* of a certain type (notice the function name is now "speakTo" instead of "speak")
```swift
speakTo("LoginViewController", messageType: "General", command: "DoSomething", message: nil)
```
The "type" your sending to here is the class name of the object.

##Send a message to a particular instance
```swift
let secondViewController = SecondViewController() //just for example
speakTo(secondViewController, messageType: "General", command: "Log", message: ["data":"print this out"])
```

**Now you must listen for the messages**
Listen's closure always passes in the arguments for speaker (String?), speakerAddr (String?), message ([String:AnyObject]?).
They are all optional so you can simply ignore them all or only one's you don't need (e.g. _, _, json in...).

This way, even when you are listening for general messages, **you can still tell who sent it**. :)

##Listen for a message from every *Listenable*
```swift
listen("Authentication", command: "Authentication.Changed") { _ in
    //listening for a message in group "Authentication" with command "Authentication.Changed"
    //also, notice, we are not expecting a message
}
```

##Listen for a message from every *Listenable* of a certain type
```swift
listenTo("LoginViewController", messageType:"Authentication", command: "Authentication.Changed") { _ in
    //listening for an auth
}
```
One nice by product of listening to an instance by type is that you can set up a listener for an object before you've even instaniated it...

##Example
*SettingsViewController* could add a listener for *NameChangeViewController* (e.g. listenTo("NameChangeViewController...)).  Now when you change your name, you can speakTo("SettingsViewController"... and pass back the new *name*.

##Listen for a message from a particular instance
```swift
listenTo(DataLayer.sharedInstance, messageType:"General", command: "Print"){ (speaker, speakerAddr, json) in
    if json != nil{
        print(json!["realMessage"] as! String)
        print("Sincerly,")
        print("\(speaker!)(\(speakerAddr!))")
    }
}
```


