"
I am a debug point which keeps track of the values of the node I am attached to. Whenever the debug point is hit the value is recorded in my history.
"
Class {
	#name : #WatchDebugPoint,
	#superclass : #DebugPoint,
	#instVars : [
		'history',
		'limit'
	],
	#category : #'DebugPointFramework-Implementations'
}

{ #category : #execution }
WatchDebugPoint >> addValue: aValue [
	self history addFirst: aValue.
	(self limit = 0) ifFalse: [ 
		self history size > self limit ifTrue: [ self history removeLast ].
	].
	
]

{ #category : #execution }
WatchDebugPoint >> history [
	^history ifNil: [ history := OrderedCollection new. ]
]

{ #category : #execution }
WatchDebugPoint >> history: anOrderedCollection [
	history := anOrderedCollection 
]

{ #category : #API }
WatchDebugPoint >> hitWithContext: aContext value: aValue [
	(self hitWithContext: aContext) ifFalse: [^self].
	
	self addValue: aValue.
	DebugPointManager notifyDebugPointChanged: self.
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
	].
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

{ #category : #initialization }
WatchDebugPoint >> name [
	^#Watcher
]

{ #category : #'ui building' }
WatchDebugPoint >> uiElement [ 
	^WatchUI new debugPoint: self.
]