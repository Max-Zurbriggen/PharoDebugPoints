"
I am responsible for managing the debug points.

An exception is the removal of Debug points, which is handled in the ""remove"" method of DebugPoint instances.
"
Class {
	#name : 'DebugPointManager',
	#superclass : 'Object',
	#category : 'DebugPointFramework-Base',
	#package : 'DebugPointFramework',
	#tag : 'Base'
}

{ #category : 'removing' }
DebugPointManager class >> handleClassRemoved: anAnnouncement [

	DebugPoint all copy do: [ :debugPoint | 
		debugPoint link methods
			detect: [ :m | m methodClass = anAnnouncement classRemoved ]
			ifFound: [ debugPoint remove"debugPoint removeFromClass: anAnnouncement classRemoved" ] ]
]

{ #category : 'removing' }
DebugPointManager class >> handleMethodModified: anAnnouncement [
	self removeFromMethod: anAnnouncement oldMethod
]

{ #category : 'removing' }
DebugPointManager class >> handleMethodRemoved: anAnnouncement [
	self removeFromMethod: anAnnouncement method
]

{ #category : 'class initialization' }
DebugPointManager class >> initialize [
	self registerInterestToSystemAnnouncement
]

{ #category : 'API' }
DebugPointManager class >> installNew: aDebugPointClass On: aNode [

	^self installNew: aDebugPointClass On: aNode withBehaviors: {  }.
]

{ #category : 'API' }
DebugPointManager class >> installNew: aDebugPointClass On: aNode withBehaviors: aListOfBehaviorClasses [
	"this should be the single point of installation for debug points, removal is in the remove method of debug point instances"
	| dp ml |

	dp := aDebugPointClass new node: aNode.


	
	ml := dp metaLink.

	dp link: ml.
	aNode link: ml.
	DebugPoint add: dp.
	
		"adding behaviors"	
	aListOfBehaviorClasses do: [ :bhc | dp addBehavior: bhc new].
	
	self notifyDebugPointAdded: dp.
	
	^dp	
]

{ #category : 'announcements' }
DebugPointManager class >> notifyDebugPointAdded: aDebugPoint [

	| announcement |
	announcement := DebugPointAdded 
		on: aDebugPoint
		nodes: aDebugPoint link nodes.
	SystemAnnouncer uniqueInstance announce: announcement
]

{ #category : 'announcements' }
DebugPointManager class >> notifyDebugPointChanged: aDebugPoint [
	
	| announcement |
	announcement := DebugPointChanged
		on: aDebugPoint
		nodes: aDebugPoint link nodes.
	SystemAnnouncer uniqueInstance announce: announcement
]

{ #category : 'announcements' }
DebugPointManager class >> notifyDebugPointRemoved: aDebugPoint fromNodes: nodes [
	"nodes have to be seperate because they will be removed from the debugpoint before this method is called"
	| announcement |
	announcement := DebugPointRemoved
		on: aDebugPoint 
		nodes: nodes.
	SystemAnnouncer uniqueInstance announce: announcement.

		

]

{ #category : 'class initialization' }
DebugPointManager class >> registerInterestToSystemAnnouncement [
	<systemEventRegistration>

	SystemAnnouncer uniqueInstance unsubscribe: self.
	SystemAnnouncer uniqueInstance weak when: MethodRemoved send: #handleMethodRemoved: to: self.
	SystemAnnouncer uniqueInstance weak when: MethodModified send: #handleMethodModified: to: self.
	SystemAnnouncer uniqueInstance weak when: ClassRemoved send: #handleClassRemoved: to: self
]

{ #category : 'removing' }
DebugPointManager class >> removeFromMethod: aMethod [

	DebugPoint all copy do: [ :debugPoint | 
		debugPoint link methods
			detect: [ :m | m == aMethod ]
			ifFound: [ debugPoint removeFromMethod: aMethod ] ]
]
