Class {
	#name : #ChainLinkDebugPoint,
	#superclass : #DebugPoint,
	#instVars : [
		'childrenDebugPoints',
		'parent'
	],
	#category : #'DebugPointFramework-Implementations'
}

{ #category : #execution }
ChainLinkDebugPoint >> addChild: aDebugPoint [
	self children add: aDebugPoint.
	(aDebugPoint class = self class) ifTrue: [ 
		aDebugPoint parent: self. ]
]

{ #category : #private }
ChainLinkDebugPoint >> children [
	^childrenDebugPoints ifNil: [ childrenDebugPoints := WeakSet new ].

]

{ #category : #API }
ChainLinkDebugPoint >> childrenDebugPoints [
	"since removing a debug point does not remove them from the chain this check has to be made, use this method instead of children when accessing the chain from the outside"
	self children copy select: [ :dp | (DebugPoint all includes: dp) not ] thenDo: [ :dp | self removeChild: dp. ].
	^self children 
]

{ #category : #execution }
ChainLinkDebugPoint >> findRoot [
	^self parent ifNil: [ self ] ifNotNil: [ self parent findRoot ].
]

{ #category : #API }
ChainLinkDebugPoint >> hitWithContext: aContext [
	
	(super hitWithContext: aContext) ifFalse: [^self].
	
	self childrenDebugPoints do: [ :cdp | cdp enabled: true ].
	self enabled: false.
]

{ #category : #execution }
ChainLinkDebugPoint >> name [
	^'ChainLink'
]

{ #category : #execution }
ChainLinkDebugPoint >> parent [
	^parent
]

{ #category : #execution }
ChainLinkDebugPoint >> parent: aDebugPoint [
	parent := aDebugPoint 
]

{ #category : #execution }
ChainLinkDebugPoint >> removeChild: aDebugPoint [
	self children remove: aDebugPoint ifAbsent: [].
	(aDebugPoint class = self class) ifTrue: [ 
		aDebugPoint parent: nil. ]
]

{ #category : #execution }
ChainLinkDebugPoint >> resetChain [

	self findRoot enabled: true.
	self findRoot resetSubChain.
	
]

{ #category : #execution }
ChainLinkDebugPoint >> resetSubChain [

	self childrenDebugPoints do: [ :child | 
		child enabled: false.
		(child class = self class ) ifTrue: [child resetSubChain ]. ]
]

{ #category : #'ui building' }
ChainLinkDebugPoint >> uiElement [ 
	^ChainLinkUI new debugPoint: self.
]
