"
history stores values up to the limit.
no limit when: limit = nil
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
	
	self history addFirst: self currentValue.
	limit ifNotNil: [ 
		self history size > self limit ifTrue: [ self history removeLast ].
	]
]

{ #category : #execution }
WatchBehavior >> expression [
	^expression
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
	^limit
]

{ #category : #execution }
WatchBehavior >> limit: anInteger [
	limit := anInteger.
	anInteger ifNotNil: [ 
		(self history size > anInteger) ifTrue: [ self history: (self history copyFrom: 1 to: anInteger) ]
	]
]

{ #category : #execution }
WatchBehavior >> requiredArguments [
	^#(context)
]

{ #category : #execution }
WatchBehavior >> uiElement [ 
	^SpLabelPresenter new label: 'Watch TOBEIMPLEMENTED'.
]
