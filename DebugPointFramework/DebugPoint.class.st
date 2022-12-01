"
I am the subclass for all debug points. New Debug points should be implemented as subclasses.
"
Class {
	#name : #DebugPoint,
	#superclass : #Object,
	#instVars : [
		'enabled',
		'behaviors',
		'arguments',
		'metaLink',
		'node',
		'targetInstance'
	],
	#classVars : [
		'AllDebugPoints'
	],
	#category : #'DebugPointFramework-Base'
}

{ #category : #adding }
DebugPoint class >> add: aDebugPoint [
	self all add: aDebugPoint.
]

{ #category : #accessing }
DebugPoint class >> all [
	^AllDebugPoints ifNil: [ AllDebugPoints := Set new. ]
]

{ #category : #adding }
DebugPoint class >> remove: aDebugPoint [

	self all remove: aDebugPoint ifAbsent: [].
	
]

{ #category : #API }
DebugPoint >> addBehavior: aDebugPointBehavior [
	"adding a new behavior"
	self behaviors add: aDebugPointBehavior.
	aDebugPointBehavior debugPoint: self.
	DebugPointManager notifyDebugPointChanged: self.

]

{ #category : #accessing }
DebugPoint >> arguments [
	^arguments
]

{ #category : #accessing }
DebugPoint >> arguments: aDictionary [
	arguments := aDictionary
]

{ #category : #accessing }
DebugPoint >> behaviors [
	^behaviors
]

{ #category : #accessing }
DebugPoint >> behaviors: aSetOfBehaviors [
	behaviors := aSetOfBehaviors 
]

{ #category : #accessing }
DebugPoint >> enabled [
	^enabled
]

{ #category : #accessing }
DebugPoint >> enabled: aBoolean [
	enabled := aBoolean.
	DebugPointManager notifyDebugPointChanged: self.
]

{ #category : #API }
DebugPoint >> getArgument: aSymbol [
	^self arguments at: aSymbol
]

{ #category : #accessing }
DebugPoint >> getBehavior: aBehaviorClass [
	^self behaviors detect: [ :bh | bh class = aBehaviorClass ] ifNone: [nil]
]

{ #category : #API }
DebugPoint >> hitWithContext: aContext [
	"returns false if the executin should be stopped, else true"
	<debuggerCompleteToSender>
	
	self enabled ifFalse: [ ^false ].
	
	self arguments: (Dictionary new 
		at: #context put: aContext; 
		yourself).
	
	"bad code? don't know how anySatisfy: works so i'm leaving it for now"
	self behaviors do: [ :behavior | 
		"API: execute should return false if it should interrupt behavior execution"
		behavior execute ifFalse: [ ^false ]
		 ].
	
	^true.
]

{ #category : #initialization }
DebugPoint >> initialize [ 
	enabled := true.
	self behaviors: (SortedCollection sortUsing: [ :elem1 :elem2 | elem1 priority >= elem2 priority]).
]

{ #category : #accessing }
DebugPoint >> layout [
	
]

{ #category : #accessing }
DebugPoint >> link [
	^metaLink
]

{ #category : #accessing }
DebugPoint >> link: aMetaLink [
	metaLink := aMetaLink 
]

{ #category : #accessing }
DebugPoint >> metaLink [
	^(MetaLink new
		metaObject: self;
		options: #(+ optionCompileOnLinkInstallation);
		selector: #hitWithContext:;
		arguments: #(context) ).
]

{ #category : #accessing }
DebugPoint >> name [
	^#Debugpoint
]

{ #category : #accessing }
DebugPoint >> node [
	^node
]

{ #category : #accessing }
DebugPoint >> node: aNode [
	node := aNode.
]

{ #category : #removing }
DebugPoint >> remove [
	| announcement nodes |
	nodes := self link nodes copy.
	
	self class remove: self.
	self link ifNotNil: [self link uninstall].
	
	announcement := DebugPointRemoved
	on: self
	nodes: nodes.
	SystemAnnouncer uniqueInstance announce: announcement.

	
]

{ #category : #API }
DebugPoint >> removeBehavior: aDebugPointBehaviorClass [
	"removing a behavior"
	self behaviors remove: (self getBehavior: aDebugPointBehaviorClass).
	DebugPointManager notifyDebugPointChanged: self.

]

{ #category : #accessing }
DebugPoint >> resetObjectScope [
	self targetInstance: nil.
	self link condition: nil arguments: nil
]

{ #category : #accessing }
DebugPoint >> setObjectScope: anObject [
	anObject ifNil: [ self resetObjectScope ].
	self targetInstance: anObject.
	self link condition: [ :ctx | ctx receiver == self targetInstance ] arguments: #(context).
]

{ #category : #accessing }
DebugPoint >> targetInstance [
	^targetInstance
]

{ #category : #accessing }
DebugPoint >> targetInstance: anObject [
	targetInstance := anObject 
]

{ #category : #'ui building' }
DebugPoint >> uiElement [
	^SpLabelPresenter new label: 'UI not implemented'.
	
]
