Class {
	#name : #DebugPoint,
	#superclass : #Object,
	#instVars : [
		'enabled',
		'behaviors',
		'arguments',
		'metaLink',
		'node'
	],
	#classVars : [
		'AllDebugPoints'
	],
	#category : #DebugPointFramework
}

{ #category : #adding }
DebugPoint class >> add: aDebugPoint [
	self all add: aDebugPoint.
	DebugPointManager notifyDebugPointAdded: aDebugPoint.
]

{ #category : #accessing }
DebugPoint class >> all [
	^AllDebugPoints ifNil: [ AllDebugPoints := Set new. ]
]

{ #category : #adding }
DebugPoint class >> remove: aDebugPoint [
	self all remove: aDebugPoint ifAbsent: [].
	DebugPointManager notifyDebugPointRemoved: aDebugPoint.
]

{ #category : #API }
DebugPoint >> addBehavior: aDebugPointBehavior [
	"adding a new behavior"
	self behaviors add: aDebugPointBehavior.
	aDebugPointBehavior debugPoint: self.

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
	enabled := aBoolean 
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

	self behaviors do: [ :behavior | 
		"this might be bad style but makes for a more robust implementation of behaviors since execution only stops if it returns false and else continues"
		"API: execute should return false if it should interrupt behavior execution"
		behavior execute = false ifTrue: [ ^false ]
		 ].
	
	^true.
]

{ #category : #initialization }
DebugPoint >> initialize [ 
	self enabled: true.
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
	
	self link ifNotNil: [self link uninstall].
	self class remove: self.
]

{ #category : #API }
DebugPoint >> removeBehavior: aDebugPointBehaviorClass [
	"removing a behavior"
	self behaviors remove: (self getBehavior: aDebugPointBehaviorClass).

]

{ #category : #accessing }
DebugPoint >> uiElement [
	^SpLabelPresenter new label: 'UI not implemented'.
	
]
