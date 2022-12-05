Class {
	#name : #ChainBehavior,
	#superclass : #DebugPointBehavior,
	#classVars : [
		'Chains'
	],
	#category : #'DebugPointFramework-Implementations'
}

{ #category : #accessing }
ChainBehavior class >> allChains [
	^Chains ifNil: [ Chains := Dictionary new. ]
]

{ #category : #accessing }
ChainBehavior class >> childFor: aDebugPoint [
	^self allChains at: aDebugPoint ifAbsent: [ ^nil ]
]

{ #category : #accessing }
ChainBehavior class >> rootFor: aDebugPoint [
	| parent |
	
	parent := self allChains keyAtValue: aDebugPoint ifAbsent: [ ^aDebugPoint ].
	^self rootFor: parent.
]

{ #category : #'ui building' }
ChainBehavior class >> uiElement [

	^ ChainLinkUI
]

{ #category : #execution }
ChainBehavior >> addChild: aDebugPoint [
	|newSet|
	newSet := (self class allChains at: self debugPoint ifAbsent: [Set new.]) .
	newSet add: aDebugPoint.
	self class allChains at: self debugPoint put: newSet.
	
	"self children add: aDebugPoint.
	aDebugPoint addBehavior: self class.
	(aDebugPoint getBehavior: self class) parent: self debugPoint."

]

{ #category : #private }
ChainBehavior >> child [
	^self class allChains at: self debugPoint ifAbsent: [ ^nil. ]
	"^childrenDebugPoints ifNil: [ childrenDebugPoints := WeakSet new ].
"
]

{ #category : #private }
ChainBehavior >> children [
	^self class allChains at: self debugPoint ifAbsent: [ ^nil. ]
	"^childrenDebugPoints ifNil: [ childrenDebugPoints := WeakSet new ].
"
]

{ #category : #API }
ChainBehavior >> childrenDebugPoints [
	"since removing a debug point does not remove them from the chain this check has to be made, use this method instead of children when accessing the chain from the outside"
	self children copy select: [ :dp | (DebugPoint all includes: dp) not ] thenDo: [ :dp | self removeChild: dp. ].
	^self children 
]

{ #category : #API }
ChainBehavior >> execute [
	"self childrenDebugPoints do: [ :cdp | cdp enabled: true ]."
	self child enabled: true.
	self debugPoint enabled: false.
]

{ #category : #execution }
ChainBehavior >> findRoot [
	^self parent ifNil: [ self debugPoint ] ifNotNil: [ ChainBehavior allChains keyAtValue: self parent ].
	"^self parent ifNil: [ self ] ifNotNil: [ self parent findRoot ]."
]

{ #category : #execution }
ChainBehavior >> parent [
	^self class allChains keyAtValue: self debugPoint ifAbsent: [^nil].
]

{ #category : #execution }
ChainBehavior >> parent: aDebugPoint [
	"parent := aDebugPoint "
]

{ #category : #execution }
ChainBehavior >> putChild: aDebugPoint [

	self class allChains at: self debugPoint put: aDebugPoint.
	
	"self children add: aDebugPoint.
	aDebugPoint addBehavior: self class.
	(aDebugPoint getBehavior: self class) parent: self debugPoint."

]

{ #category : #execution }
ChainBehavior >> remove [ 
	"removing element as child and as parent of other debug points"
]

{ #category : #execution }
ChainBehavior >> removeChild: aDebugPoint [
	self children remove: aDebugPoint ifAbsent: [].
	(aDebugPoint getBehavior: self class) parent: nil.
]

{ #category : #execution }
ChainBehavior >> resetChain [

	self findRoot enabled: true.
	self resetSubChain: self findRoot .
	
]

{ #category : #execution }
ChainBehavior >> resetSubChain [
	self child ifNotNil: [ :child | child].
	self child enabled: false.
	self child ifNotNil: [ :child | child getBehavior: ChainBehavior   ].
	
"	self childrenDebugPoints do: [ :child | 
		child enabled: false.
		(child class = self class ) ifTrue: [child resetSubChain ]. ]"
]

{ #category : #execution }
ChainBehavior >> resetSubChain: aDebugPoint [
	| child |
	child := 	self class allChains at: aDebugPoint ifAbsent: [ ^nil. ].
	child ifNotNil: [ child enabled: false.
		self resetSubChain: child].

	
"	self childrenDebugPoints do: [ :child | 
		child enabled: false.
		(child class = self class ) ifTrue: [child resetSubChain ]. ]"
]
