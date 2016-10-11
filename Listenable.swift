//
//  Listenable.swift
//  Authentication
//
//  Created by Andrew Goodwin on 9/7/16.
//  Copyright © 2016 Conway Corporation. All rights reserved.
//

import Foundation

protocol Listenable: class {
    
}

extension Listenable{
    
    //Speak to all who are listening for a message of this type with this command
    func speak(messageType:String, command:String, message:[String:AnyObject]?){
        let speakerString = Mirror(reflecting: self).description.stringByReplacingOccurrencesOfString("Mirror for ", withString: "")
        let speakerAddr = "\(unsafeAddressOf(self))" ?? ""
        let listeners = Listeners.sharedListeners.dataListeners.filter({$0.messageType == messageType && $0.command == command})
        for li in listeners{
            li.speak(speakerString, speakerAddr, message)
        }
    }
    
    //Speak to listeners by string who are listening for a message of this type with this command
    func speakTo(listener:String, messageType:String, command:String, message:[String:AnyObject]?){
        let speakerString = Mirror(reflecting: self).description.stringByReplacingOccurrencesOfString("Mirror for ", withString: "")
        let speakerAddr = "\(unsafeAddressOf(self))" ?? ""
        let listeners = Listeners.sharedListeners.dataListeners.filter({$0.listener == listener && $0.messageType == messageType && $0.command == command})
        for li in listeners{
            li.speak(speakerString, speakerAddr, message)
        }
    }
    
    //Speak to a listener by instance who is listening for a message of this type with this command
    func speakTo(listener:Listenable, messageType:String, command:String, message:[String:AnyObject]?){
        let speakerString = Mirror(reflecting: self).description.stringByReplacingOccurrencesOfString("Mirror for ", withString: "")
        let speakerAddr = "\(unsafeAddressOf(self))" ?? ""
        let listenerString = Mirror(reflecting: listener).description.stringByReplacingOccurrencesOfString("Mirror for ", withString: "")
        let listenerAddr = "\(unsafeAddressOf(listener))" ?? ""
        let listeners = Listeners.sharedListeners.dataListeners.filter({
            if $0.listenerAddress == listenerAddr && $0.listener == listenerString && $0.messageType == messageType && $0.command == command{
                return true
            }
            else{
                return false
            }
        })
        for li in listeners{
            li.speak(speakerString, speakerAddr, message)
        }
    }
    
    //Listen for a message of this type with this command
    func listen(messageType:String, command:String, message:((String?, String?, [String:AnyObject]?) -> Void)){
        let listener = Mirror(reflecting: self).description.stringByReplacingOccurrencesOfString("Mirror for ", withString: "")
        let listenerAddr = "\(unsafeAddressOf(self))" ?? ""
        let newListener = DataListener(listener:listener, messageType: messageType, command: command, speak: message)
        newListener.listenerAddress = listenerAddr
        let filtered = Listeners.sharedListeners.dataListeners.filter({
            let thisListener = $0
            if thisListener.messageType == messageType && thisListener.command == command && thisListener.speaker == "" && thisListener.listener == listener{
                return true
            }
            else{
                return false
            }
        })
        
        if filtered.count == 0{
            //listenerIds.append(newListener.id)
            Listeners.sharedListeners.dataListeners.append(newListener)
        }
    }
    
    //Listen for a message of this type with this command
    func doListen(messageType:String, command:String, message:((String?, String?, [String:AnyObject]?) -> Void)){
        let listener = Mirror(reflecting: self).description.stringByReplacingOccurrencesOfString("Mirror for ", withString: "")
        let listenerAddr = "\(unsafeAddressOf(self))" ?? ""
        let newListener = DataListener(listener:listener, messageType: messageType, command: command, speak: message)
        newListener.listenerAddress = listenerAddr
        let filtered = Listeners.sharedListeners.dataListeners.filter({
            let thisListener = $0
            if thisListener.messageType == messageType && thisListener.command == command && thisListener.speaker == "" && thisListener.listener == listener{
                return true
            }
            else{
                return false
            }
        })
        
        if filtered.count == 0{
            //listenerIds.append(newListener.id)
            Listeners.sharedListeners.dataListeners.append(newListener)
        }
        
        message(listener,listenerAddr,nil)
    }
    
    //Listen to a certain speaker by string for a message of this type with this command
    func listenTo(speaker:String, messageType:String, command:String, message:((String?, String?, [String:AnyObject]?) -> Void)){
        let listener = Mirror(reflecting: self).description.stringByReplacingOccurrencesOfString("Mirror for ", withString: "")
        let listenerAddr = "\(unsafeAddressOf(self))" ?? ""
        let newListener = DataListener(speaker:speaker, listener:listener, messageType: messageType, command: command, speak: message)
        newListener.listenerAddress = listenerAddr
        
        let filtered = Listeners.sharedListeners.dataListeners.filter({
            let thisListener = $0
            if thisListener.messageType == messageType && thisListener.command == command && thisListener.speaker == speaker && thisListener.listener == listener{
                return true
            }
            else{
                return false
            }
        })
        
        if filtered.count == 0{
            //listenerIds.append(newListener.id)
            Listeners.sharedListeners.dataListeners.append(newListener)
        }
    }
    
    //Listen to a certain speaker by string for a message of this type with this command
    func doListenTo(speaker:String, messageType:String, command:String, message:((String?, String?, [String:AnyObject]?) -> Void)){
        let listener = Mirror(reflecting: self).description.stringByReplacingOccurrencesOfString("Mirror for ", withString: "")
        let listenerAddr = "\(unsafeAddressOf(self))" ?? ""
        let newListener = DataListener(speaker:speaker, listener:listener, messageType: messageType, command: command, speak: message)
        newListener.listenerAddress = listenerAddr
        
        let filtered = Listeners.sharedListeners.dataListeners.filter({
            let thisListener = $0
            if thisListener.messageType == messageType && thisListener.command == command && thisListener.speaker == speaker && thisListener.listener == listener{
                return true
            }
            else{
                return false
            }
        })
        
        if filtered.count == 0{
            //listenerIds.append(newListener.id)
            Listeners.sharedListeners.dataListeners.append(newListener)
        }
        
        message(listener,listenerAddr,nil)
    }
    
    //Listen to a certain speaker by instance for a message of this type with this command
    func listenTo(speaker:Listenable, messageType:String, command:String, message:((String?, String?, [String:AnyObject]?) -> Void)){
        let listener = Mirror(reflecting: self).description.stringByReplacingOccurrencesOfString("Mirror for ", withString: "")
        let speakerString = Mirror(reflecting: speaker).description.stringByReplacingOccurrencesOfString("Mirror for ", withString: "")
        let speakerAddr = "\(unsafeAddressOf(speaker))" ?? ""
        let listenerAddr = "\(unsafeAddressOf(self))" ?? ""
        let newListener = DataListener(speaker:speakerString, listener:listener, messageType: messageType, command: command, speak: message)
        newListener.speakerAddress = speakerAddr
        newListener.listenerAddress = listenerAddr
        
        let filtered = Listeners.sharedListeners.dataListeners.filter({
            let thisListener = $0
            if thisListener.messageType == messageType && thisListener.command == command && thisListener.speaker == speakerString && thisListener.listener == listener && thisListener.speakerAddress == speakerAddr{
                return true
            }
            else{
                return false
            }
        })
        
        if filtered.count == 0{
            //listenerIds.append(newListener.id)
            Listeners.sharedListeners.dataListeners.append(newListener)
        }
    }
    
    //Listen to a certain speaker by instance for a message of this type with this command
    func doListenTo(speaker:Listenable, messageType:String, command:String, message:((String?, String?, [String:AnyObject]?) -> Void)){
        let listener = Mirror(reflecting: self).description.stringByReplacingOccurrencesOfString("Mirror for ", withString: "")
        let speakerString = Mirror(reflecting: speaker).description.stringByReplacingOccurrencesOfString("Mirror for ", withString: "")
        let speakerAddr = "\(unsafeAddressOf(speaker))" ?? ""
        let listenerAddr = "\(unsafeAddressOf(self))" ?? ""
        let newListener = DataListener(speaker:speakerString, listener:listener, messageType: messageType, command: command, speak: message)
        newListener.speakerAddress = speakerAddr
        newListener.listenerAddress = listenerAddr
        
        let filtered = Listeners.sharedListeners.dataListeners.filter({
            let thisListener = $0
            if thisListener.messageType == messageType && thisListener.command == command && thisListener.speaker == speakerString && thisListener.listener == listener && thisListener.speakerAddress == speakerAddr{
                return true
            }
            else{
                return false
            }
        })
        
        if filtered.count == 0{
            //listenerIds.append(newListener.id)
            Listeners.sharedListeners.dataListeners.append(newListener)
        }
        
        message(listener,listenerAddr,nil)
    }
    
    //Stop listening to a certain speaker by instance having a message of this type with this command
    func stopListeningTo(speaker:Listenable, messageType:String, command:String){
        let listener = Mirror(reflecting: self).description.stringByReplacingOccurrencesOfString("Mirror for ", withString: "")
        let speakerString = Mirror(reflecting: speaker).description.stringByReplacingOccurrencesOfString("Mirror for ", withString: "")
        let speakerAddr = "\(unsafeAddressOf(speaker))" ?? ""
        Listeners.sharedListeners.dataListeners = Listeners.sharedListeners.dataListeners.filter({
            let thisListener = $0
            if thisListener.messageType == messageType && thisListener.command == command && thisListener.speaker == speakerString && thisListener.listener == listener && thisListener.speakerAddress == speakerAddr{
                return false
            }
            else{
                return true
            }
        })
    }

    //Stop listening to a certain speaker by string having a message of this type with this command
    func stopListeningTo(speaker:String, messageType:String, command:String){
        let listener = Mirror(reflecting: self).description.stringByReplacingOccurrencesOfString("Mirror for ", withString: "")
        Listeners.sharedListeners.dataListeners = Listeners.sharedListeners.dataListeners.filter({
            let thisListener = $0
            if thisListener.messageType == messageType && thisListener.command == command && thisListener.speaker == speaker && thisListener.listener == listener{
                return false
            }
            else{
                return true
            }
        })
    }
    
    //Stop listening for a message of this type with this command
    func stopListening(messageType:String, command:String){
        let listener = Mirror(reflecting: self).description.stringByReplacingOccurrencesOfString("Mirror for ", withString: "")
        Listeners.sharedListeners.dataListeners = Listeners.sharedListeners.dataListeners.filter({
            let thisListener = $0
            if thisListener.messageType == messageType && thisListener.command == command && thisListener.listener == listener{
                return false
            }
            else{
                return true
            }
        })
    }
    
    //Stop listening to a certain speaker by instance
    func stopListeningTo(speaker:Listenable){
        let listener = Mirror(reflecting: self).description.stringByReplacingOccurrencesOfString("Mirror for ", withString: "")
        let speakerString = Mirror(reflecting: speaker).description.stringByReplacingOccurrencesOfString("Mirror for ", withString: "")
        let speakerAddr = "\(unsafeAddressOf(speaker))" ?? ""
        Listeners.sharedListeners.dataListeners = Listeners.sharedListeners.dataListeners.filter({
            let thisListener = $0
            if thisListener.listener == listener && thisListener.speaker == speakerString && thisListener.speakerAddress == speakerAddr{
                return false
            }
            else{
                return true
            }
        })
    }
    
    //Stop listening to a certain speaker by string
    func stopListeningTo(speaker:String){
        let listener = Mirror(reflecting: self).description.stringByReplacingOccurrencesOfString("Mirror for ", withString: "")
        Listeners.sharedListeners.dataListeners = Listeners.sharedListeners.dataListeners.filter({
            let thisListener = $0
            if thisListener.listener == listener && thisListener.speaker == speaker{
                return false
            }
            else{
                return true
            }
        })
    }
    
    //Stop listening all together
    func stopListening(){
        let listener = Mirror(reflecting: self).description.stringByReplacingOccurrencesOfString("Mirror for ", withString: "")
        Listeners.sharedListeners.dataListeners = Listeners.sharedListeners.dataListeners.filter({
            let thisListener = $0
            if thisListener.listener == listener{
                return false
            }
            else{
                return true
            }
        })
    }
}