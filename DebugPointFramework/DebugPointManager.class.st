Class {
	#name : #DebugPointManager,
	#superclass : #Object,
	#category : #DebugPointFramework
}

{ #category : #'class initialization' }
DebugPointManager class >> handleClassRemoved: anAnnouncement [

	DebugPoint all copy do: [ :debugPoint | 
		debugPoint link methods
			detect: [ :m | m methodClass = anAnnouncement classRemoved ]
			ifFound: [ debugPoint remove"debugPoint removeFromClass: anAnnouncement classRemoved" ] ]
]

{ #category : #'class initialization' }
DebugPointManager class >> handleMethodModified: anAnnouncement [
	self removeFromMethod: anAnnouncement oldMethod
]

{ #category : #'class initialization' }
DebugPointManager class >> handleMethodRemoved: anAnnouncement [
	self removeFromMethod: anAnnouncement method
]

{ #category : #'class initialization' }
DebugPointManager class >> initialize [
	self registerInterestToSystemAnnouncement
]

{ #category : #'as yet unclassified' }
DebugPointManager class >> installNew: aDebugPointClass On: aNode [

	self installNew: aDebugPointClass On: aNode withBehaviors: {  }.
]

{ #category : #'as yet unclassified' }
DebugPointManager class >> installNew: aDebugPointClass On: aNode withBehaviors: aListOfBehaviorClasses [
	"this should be the single point of installation for debug points, removal is in the remove method of debug point instances"
	| dp ml |

	dp := aDebugPointClass new node: aNode.

	"adding behaviors"	
	aListOfBehaviorClasses do: [ :bhc | dp addBehavior: bhc new].
	
	ml := dp metaLink.

	dp link: ml.
	aNode link: ml.
	DebugPoint add: dp.
	self notifyDebugPointAdded: dp.
	
]

{ #category : #'as yet unclassified' }
DebugPointManager class >> notifyDebugPointAdded: aDebugPoint [

	| announcement |
	announcement := DebugPointAdded 
		on: aDebugPoint
		nodes: aDebugPoint link nodes.
	SystemAnnouncer uniqueInstance announce: announcement
]

{ #category : #'as yet unclassified' }
DebugPointManager class >> notifyDebugPointRemoved: aDebugPoint fromNodes: nodes [
	"nodes have to be seperate because they will be removed from the debugpoint before this method is called"
	| announcement |
	announcement := DebugPointRemoved
		on: aDebugPoint 
		nodes: nodes.
	SystemAnnouncer uniqueInstance announce: announcement.

		

]

{ #category : #'class initialization' }
DebugPointManager class >> registerInterestToSystemAnnouncement [
	<systemEventRegistration>

	SystemAnnouncer uniqueInstance unsubscribe: self.
	SystemAnnouncer uniqueInstance weak when: MethodRemoved send: #handleMethodRemoved: to: self.
	SystemAnnouncer uniqueInstance weak when: MethodModified send: #handleMethodModified: to: self.
	SystemAnnouncer uniqueInstance weak when: ClassRemoved send: #handleClassRemoved: to: self
]

{ #category : #'class initialization' }
DebugPointManager class >> removeFromMethod: aMethod [

	DebugPoint all copy do: [ :debugPoint | 
		debugPoint link methods
			detect: [ :m | m == aMethod ]
			ifFound: [ debugPoint remove"debugPoint removeFromMethod: aMethod" ] ]
]
