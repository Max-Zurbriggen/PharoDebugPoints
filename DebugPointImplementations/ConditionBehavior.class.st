Class {
	#name : #ConditionBehavior,
	#superclass : #DebugPointBehavior,
	#instVars : [
		'condition'
	],
	#category : #DebugPointImplementations
}

{ #category : #initialization }
ConditionBehavior >> condition [
	^condition
]

{ #category : #initialization }
ConditionBehavior >> condition: aCondition [
	condition := aCondition
]

{ #category : #initialization }
ConditionBehavior >> context [
	^self getArgument: #context
]

{ #category : #initialization }
ConditionBehavior >> evaluate: expression withContext: aContext [
	^ Smalltalk compiler
		source: expression;
		context: aContext;
		receiver: aContext receiver;
		bindings: { #thisContext -> aContext };
		evaluate
]

{ #category : #execution }
ConditionBehavior >> execute [
	self condition ifNil: [ ^self ].
	(self evaluate: self condition withContext: self context) ifFalse: [ ^false ]
]

{ #category : #initialization }
ConditionBehavior >> initialize [ 
	"should be executed before once and count etc."
	super initialize.
	self priority: 50.
	self condition: 'false'.
]

{ #category : #accessing }
ConditionBehavior >> uiElement [

	^ConditionUI new behavior: self.
]
