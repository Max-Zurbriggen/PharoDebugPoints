Class {
	#name : #ChainLinkDebugPoint,
	#superclass : #DebugPoint,
	#instVars : [
		'childrenDebugPoints'
	],
	#category : #'DebugPointFramework-Implementations'
}

{ #category : #execution }
ChainLinkDebugPoint >> addChild: aDebugPoint [
	self childrenDebugPoints add: aDebugPoint.
]

{ #category : #execution }
ChainLinkDebugPoint >> childrenDebugPoints [
	^childrenDebugPoints ifNil: [ childrenDebugPoints := WeakOrderedCollection new ]
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
ChainLinkDebugPoint >> removeChild: aDebugPoint [
	self childrenDebugPoints remove: aDebugPoint ifAbsent: [].
]

{ #category : #'ui building' }
ChainLinkDebugPoint >> uiElement [ 
	^SpLabelPresenter new label: 'Chain TOBEIMPLEMENTED'.
]
