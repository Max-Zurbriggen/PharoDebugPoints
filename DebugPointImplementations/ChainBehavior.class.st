Class {
	#name : #ChainBehavior,
	#superclass : #DebugPointBehavior,
	#instVars : [
		'childrenDebugPoints'
	],
	#category : #DebugPointImplementations
}

{ #category : #execution }
ChainBehavior >> addChild: aDebugPoint [
	self childrenDebugPoints add: aDebugPoint.
]

{ #category : #execution }
ChainBehavior >> childrenDebugPoints [
	^childrenDebugPoints ifNil: [ childrenDebugPoints := WeakOrderedCollection new ]
]

{ #category : #execution }
ChainBehavior >> execute [ 
	self childrenDebugPoints do: [ :cdp | cdp enabled: true ].
	self debugPoint enabled: false.
]

{ #category : #execution }
ChainBehavior >> removeChild: aDebugPoint [
	self childrenDebugPoints remove: aDebugPoint ifAbsent: [].
]

{ #category : #accessing }
ChainBehavior >> uiElement [ 
	^SpLabelPresenter new label: 'Chain TOBEIMPLEMENTED'.
]
