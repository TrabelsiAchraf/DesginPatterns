# DesginPatterns

![](https://img.shields.io/badge/build-passing-brightgreen.svg)
![](https://img.shields.io/badge/platform-macOS-lightgrey.svg)

## Behavioral : 

### Observer Pattern

 - One object notifies other objects about its state change.
 - It is a one-to-many relationship.
 - When the state of one object changes, other object which are subscribed to it gets notified about the state change.
 - Observable protocol has three abstract methods : 
    * add(observerX) : to add an observer.
    * remove(observerX) : to remove a specific observer.
    * notify() : to notify all observers.
