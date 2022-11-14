Class {
	#name : #WatchDebugPoint,
	#superclass : #DebugPoint,
	#instVars : [
		'history',
		'limit'
	],
	#category : #DebugPointImplementations
}

{ #category : #execution }
WatchDebugPoint >> addValue: aValue [
	self history addFirst: aValue.
	(self limit = 0) ifFalse: [ 
		self history size > self limit ifTrue: [ self history removeLast ].
	]
]

{ #category : #execution }
WatchDebugPoint >> history [
	^history ifNil: [ history := OrderedCollection new. ]
]

{ #category : #execution }
WatchDebugPoint >> history: anOrderedCollection [
	history := anOrderedCollection 
]

{ #category : #initialization }
WatchDebugPoint >> hitWithContext: aContext value: aValue [
	self hitWithContext: aContext.
	
	self addValue: aValue.
]

{ #category : #execution }
WatchDebugPoint >> limit [
	^limit ifNil: [ limit := 0 ]
]

{ #category : #execution }
WatchDebugPoint >> limit: anInteger [
	limit := anInteger.
	(anInteger = 0) ifFalse: [ 
		(self history size > anInteger) ifTrue: [ self history: (self history copyFrom: 1 to: anInteger) ]
	]
]

{ #category : #initialization }
WatchDebugPoint >> metaLink [
	^(MetaLink new 
				metaObject: self;
				selector: #hitWithContext:value:;
				arguments: #(context value);
				control: #after;
				option: #(+ optionWeakAfter +optionAnnounce)).
]

{ #category : #execution }
WatchDebugPoint >> uiElement [ 
	^WatchUI new behavior: self.
]
