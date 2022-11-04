Class {
	#name : #DebugPoint,
	#superclass : #Object,
	#instVars : [
		'enabled',
		'behaviors',
		'requiredArguments',
		'arguments',
		'metaLink'
	],
	#classVars : [
		'AllDebugPoints'
	],
	#category : #DebugPointFramework
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
	"adding required arguments for this behavior"
	self requiredArguments add: aDebugPointBehavior requiredArguments.
	self requiredArguments: self requiredArguments flattened asSet.
	
	"alternative version for adding required arguments so we dont have to flatten manually:"
	"aDebugPointBehavior requiredArguments do: [ :arg | self requiredArguments add: arg ]."
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
	^self behaviors detect: [ :bh | bh class = aBehaviorClass ]
]

{ #category : #API }
DebugPoint >> hit [
	<debuggerCompleteToSender>
	
	self enabled ifFalse: [ ^self ].
	self behaviors do: [ :behavior | 
		"this might be bad style but makes for a more robust implementation of behaviors since execution only stops if it returns false and else continues"
		"API: execute should return false if it should interrupt behavior execution"
		behavior execute = false ifTrue: [ ^self ]

		 ]
]

{ #category : #API }
DebugPoint >> hitWithArguments: aDictionary [
	"workaround because metalinks don't return dictionaries"
	self arguments: (Dictionary new at: #context put: aDictionary; yourself).
	"self arguments: aDictionary."
	self hit.
]

{ #category : #initialization }
DebugPoint >> initialize [ 
	self class add: self.
	self enabled: true.
	self behaviors: (SortedCollection sortUsing: [ :elem1 :elem2 | elem1 priority >= elem2 priority]).
	self requiredArguments: Set new.
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
DebugPoint >> openEditor [ 
	| sp |
	sp := DebugPointEditor new.
	sp layout: SpBoxLayout newTopToBottom.
	self behaviors do: [ :bh | sp layout add: bh uiElement expand: false fill: true padding: 10  ].
	sp open.
	
]

{ #category : #removing }
DebugPoint >> remove [
	
	self link ifNotNil: [self link uninstall].
	self class remove: self.
]

{ #category : #accessing }
DebugPoint >> requiredArguments [
	^requiredArguments
]

{ #category : #accessing }
DebugPoint >> requiredArguments: aList [
	requiredArguments := aList
]
