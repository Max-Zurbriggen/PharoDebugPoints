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
		evaluate
]

{ #category : #execution }
ConditionBehavior >> execute [
	(self evaluate: self condition withContext: self context) ifFalse: [ ^false ]
]

{ #category : #initialization }
ConditionBehavior >> initialize [ 
	"should be executed before once and count etc."
	super initialize.
	self priority: 50
]

{ #category : #initialization }
ConditionBehavior >> requiredArguments [
	^#(context)
]
