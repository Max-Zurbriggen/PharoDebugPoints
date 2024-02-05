"
I am the subclass for all debug points. New Debug points should be implemented as subclasses.
"
Class {
	#name : 'DebugPoint',
	#superclass : 'Object',
	#instVars : [
		'name',
		'enabled',
		'behaviors',
		'arguments',
		'metaLink',
		'node',
		'targetInstance',
		'properties'
	],
	#classVars : [
		'AllDebugPoints'
	],
	#category : 'DebugPointFramework-Base',
	#package : 'DebugPointFramework',
	#tag : 'Base'
}

{ #category : 'adding' }
DebugPoint class >> add: aDebugPoint [
	self all add: aDebugPoint.
]

{ #category : 'accessing' }
DebugPoint class >> all [
	^AllDebugPoints ifNil: [ AllDebugPoints := Set new. ]
]

{ #category : 'adding' }
DebugPoint class >> remove: aDebugPoint [

	self all remove: aDebugPoint ifAbsent: [].
	
]

{ #category : 'API' }
DebugPoint >> addBehavior: aDebugPointBehavior [
	"adding a new behavior"
	(self getBehavior: aDebugPointBehavior class) ifNotNil: [ :bh | ^bh ].
	self behaviors add: aDebugPointBehavior.
	aDebugPointBehavior debugPoint: self.
	DebugPointManager notifyDebugPointChanged: self.
	
]

{ #category : 'accessing' }
DebugPoint >> arguments [
	^arguments
]

{ #category : 'accessing' }
DebugPoint >> arguments: aDictionary [
	arguments := aDictionary
]

{ #category : 'accessing' }
DebugPoint >> behaviors [
	^behaviors
]

{ #category : 'accessing' }
DebugPoint >> behaviors: aSetOfBehaviors [
	behaviors := aSetOfBehaviors 
]

{ #category : 'reflective operations' }
DebugPoint >> doesNotUnderstand: message [
	"forward not understood messages to behaviors, 'delegation complements composition' "
	self behaviors do: [ :bh | 
		(bh respondsTo: message selector)
			ifTrue: [ ^bh perform: message selector withEnoughArguments: message arguments ]
		].
	
	^super doesNotUnderstand: message
]

{ #category : 'accessing' }
DebugPoint >> enabled [
	^enabled
]

{ #category : 'accessing' }
DebugPoint >> enabled: aBoolean [
	enabled := aBoolean.
	DebugPointManager notifyDebugPointChanged: self.
]

{ #category : 'accessing' }
DebugPoint >> getArgument: aSymbol [
	^self arguments at: aSymbol
]

{ #category : 'accessing' }
DebugPoint >> getBehavior: aBehaviorClass [
	^self behaviors detect: [ :bh | bh class = aBehaviorClass ] ifNone: [nil]
]

{ #category : 'API' }
DebugPoint >> hitWithContext: aContext [
	"returns false if the execution should be stopped, else true"
	<debuggerCompleteToSender>
	self enabled ifFalse: [ ^false ].
	self arguments: (Dictionary new 
		at: #context put: aContext; 
		yourself).
	^self behaviors allSatisfy: [ :behavior | behavior execute].
	

]

{ #category : 'initialization' }
DebugPoint >> initialize [ 
	enabled := true.
	self behaviors: (SortedCollection sortUsing: [ :elem1 :elem2 | elem1 priority >= elem2 priority]).
]

{ #category : 'accessing' }
DebugPoint >> link [
	^metaLink
]

{ #category : 'accessing' }
DebugPoint >> link: aMetaLink [
	metaLink := aMetaLink 
]

{ #category : 'initialization' }
DebugPoint >> metaLink [
	^(MetaLink new
		metaObject: self;
		options: #(+ optionCompileOnLinkInstallation);
		selector: #hitWithContext:;
		arguments: #(context) ).
]

{ #category : 'accessing' }
DebugPoint >> method [
"returns the method to which the debug point is attached"
	^self node methodNode method
]

{ #category : 'accessing' }
DebugPoint >> name [
	^name ifNil: [ #Debugpoint ]
]

{ #category : 'accessing' }
DebugPoint >> name: aSymbol [
	name := aSymbol
]

{ #category : 'accessing' }
DebugPoint >> node [
	^node
]

{ #category : 'accessing' }
DebugPoint >> node: aNode [
	node := aNode.
]

{ #category : 'accessing' }
DebugPoint >> properties [ 
	^properties ifNil: [ properties := Dictionary new. ]
]

{ #category : 'removing' }
DebugPoint >> remove [
	| announcement nodes |
	nodes := self link nodes copy.
	self behaviors do: [ :bh | bh remove ].
	self class remove: self.
	self link ifNotNil: [self link uninstall].
	
	announcement := DebugPointRemoved
	on: self
	nodes: nodes.
	SystemAnnouncer uniqueInstance announce: announcement.
	
	
	
]

{ #category : 'API' }
DebugPoint >> removeBehavior: aDebugPointBehaviorClass [
	"removing a behavior"
	|behavior|
	behavior := (self getBehavior: aDebugPointBehaviorClass).
	behavior remove.
	self behaviors remove: behavior.
	DebugPointManager notifyDebugPointChanged: self.

]

{ #category : 'removing' }
DebugPoint >> removeFromMethod: aMethod [
	"only used when editing methods with debug points"
	|  nodes |
	nodes := self link nodes copy.
	self behaviors do: [ :bh | bh remove ].
	self class remove: self.

	DebugPointManager notifyDebugPointRemoved: self fromNodes: nodes.


	
]

{ #category : 'API' }
DebugPoint >> resetObjectScope [
	self targetInstance: nil.
	self link condition: nil arguments: nil
]

{ #category : 'API' }
DebugPoint >> setObjectScope: anObject [

	"this might get changed such that the metalink will be attached to the instance directly instead of checking on all instances"
	anObject ifNil: [ self resetObjectScope ].
	self targetInstance: anObject.
	self link condition: [ :ctx | ctx receiver == self targetInstance ] arguments: #(context).
]

{ #category : 'accessing' }
DebugPoint >> targetInstance [
	^targetInstance
]

{ #category : 'accessing' }
DebugPoint >> targetInstance: anObject [
	targetInstance := anObject 
]

{ #category : 'ui building' }
DebugPoint >> uiElement [
	^nil
	
]
