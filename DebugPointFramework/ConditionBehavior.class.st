"
I am the condition behavior which can be added to debug points. If my condition is true or nil the execute method will return true, else it will return false or an error.
"
Class {
	#name : #ConditionBehavior,
	#superclass : #DebugPointBehavior,
	#instVars : [
		'condition'
	],
	#category : #'DebugPointFramework-Behaviors'
}

{ #category : #accessing }
ConditionBehavior class >> uiElement [

	^ConditionUI
]

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
	self condition ifNil: [ ^true ].
	(self evaluate: self condition withContext: self context) ifFalse: [ ^false ].
	^true
]

{ #category : #initialization }
ConditionBehavior >> initialize [ 
	"should be executed before once and count etc."
	super initialize.
	self priority: 50.
	self condition: 'false'.
]

{ #category : #storing }
ConditionBehavior >> saveState [ 
	self debugPoint properties at: #Condition put: self condition.
]
