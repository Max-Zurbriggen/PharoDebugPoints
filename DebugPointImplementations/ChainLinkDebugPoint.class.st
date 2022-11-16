Class {
	#name : #ChainLinkDebugPoint,
	#superclass : #DebugPoint,
	#instVars : [
		'childrenDebugPoints'
	],
	#category : #DebugPointImplementations
}

{ #category : #execution }
ChainLinkDebugPoint >> addChild: aDebugPoint [
	self childrenDebugPoints add: aDebugPoint.
]

{ #category : #execution }
ChainLinkDebugPoint >> childrenDebugPoints [
	^childrenDebugPoints ifNil: [ childrenDebugPoints := WeakOrderedCollection new ]
]

{ #category : #execution }
ChainLinkDebugPoint >> hitWithContext: aContext [
	
	(super hitWithContext: aContext) ifFalse: [^self].
	
	self childrenDebugPoints do: [ :cdp | cdp enabled: true ].
	self debugPoint enabled: false.
]

{ #category : #execution }
ChainLinkDebugPoint >> removeChild: aDebugPoint [
	self childrenDebugPoints remove: aDebugPoint ifAbsent: [].
]

{ #category : #accessing }
ChainLinkDebugPoint >> uiElement [ 
	^SpLabelPresenter new label: 'Chain TOBEIMPLEMENTED'.
]
