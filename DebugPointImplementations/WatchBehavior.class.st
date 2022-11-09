"
history stores values up to the limit.
no limit when: limit = nil

At the moment it references objects so the objects can still change before looking at the history.
"
Class {
	#name : #WatchBehavior,
	#superclass : #DebugPointBehavior,
	#instVars : [
		'history',
		'limit',
		'expression'
	],
	#category : #DebugPointImplementations
}

{ #category : #execution }
WatchBehavior >> context [
	^self getArgument: #context
]

{ #category : #execution }
WatchBehavior >> currentValue [
	
	^self evaluate: self expression withContext: self context.
]

{ #category : #initialization }
WatchBehavior >> evaluate: tExpression withContext: aContext [
	^ Smalltalk compiler
		source: tExpression;
		context: aContext;
		receiver: aContext receiver;
		bindings: { #thisContext -> aContext };
		evaluate
]

{ #category : #execution }
WatchBehavior >> execute [ 
	self expression ifNil: [ ^self ].
	self history addFirst: self currentValue.
	(self limit = 0) ifFalse: [ 
		self history size > self limit ifTrue: [ self history removeLast ].
	]
]

{ #category : #execution }
WatchBehavior >> expression [
	^expression ifNil: [ '' ]
]

{ #category : #execution }
WatchBehavior >> expression: aString [
	expression := aString
]

{ #category : #execution }
WatchBehavior >> history [
	^history ifNil: [ history := OrderedCollection new. ]
]

{ #category : #execution }
WatchBehavior >> history: anOrderedCollection [
	history := anOrderedCollection 
]

{ #category : #execution }
WatchBehavior >> limit [
	^limit ifNil: [ limit := 0 ]
]

{ #category : #execution }
WatchBehavior >> limit: anInteger [
	limit := anInteger.
	(anInteger = 0) ifFalse: [ 
		(self history size > anInteger) ifTrue: [ self history: (self history copyFrom: 1 to: anInteger) ]
	]
]

{ #category : #execution }
WatchBehavior >> uiElement [ 
	^WatchUI new behavior: self.
]
