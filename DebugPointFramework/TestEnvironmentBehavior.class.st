"
I am a behavior that can be added to debug points. I check if the current execution context is a test. Only if the debug point is reached when running a test the execution of behaviors continues, otherwise it interrupts.
"
Class {
	#name : #TestEnvironmentBehavior,
	#superclass : #DebugPointBehavior,
	#category : #'DebugPointFramework-Behaviors'
}

{ #category : #accessing }
TestEnvironmentBehavior class >> uiElement [

	^TestEnvironmentUI
]

{ #category : #accessing }
TestEnvironmentBehavior >> context [
	^self getArgument: #context
]

{ #category : #private }
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
