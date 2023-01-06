Class {
	#name : #TestEnvironmentBehavior,
	#superclass : #DebugPointBehavior,
	#category : #'DebugPointFramework-Behaviors'
}

{ #category : #accessing }
TestEnvironmentBehavior class >> uiElement [

	^TestEnvironmentUI
]

{ #category : #initialization }
TestEnvironmentBehavior >> context [
	^self getArgument: #context
]

{ #category : #initialization }
TestEnvironmentBehavior >> evaluate: expression withContext: aContext [
	^ Smalltalk compiler
		source: expression;
		context: aContext;
		receiver: aContext receiver;
		bindings: { #thisContext -> aContext };
		evaluate
]

{ #category : #execution }
TestEnvironmentBehavior >> execute [
	(CurrentExecutionEnvironment value isTest) ifFalse: [ ^false ].
	"(self evaluate: self condition withContext: self context) ifFalse: [ ^false ]."
	^true

]

{ #category : #initialization }
TestEnvironmentBehavior >> initialize [ 
	"should be executed before once and count etc."
	super initialize.
	self priority: 50.
]
