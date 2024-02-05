"
I am a behavior that can be added to debug points. I check if the current execution context is a test. Only if the debug point is reached when running a test the execution of behaviors continues, otherwise it interrupts.
"
Class {
	#name : 'TestEnvironmentBehavior',
	#superclass : 'DebugPointBehavior',
	#category : 'DebugPointFramework-Behaviors',
	#package : 'DebugPointFramework',
	#tag : 'Behaviors'
}

{ #category : 'accessing' }
TestEnvironmentBehavior class >> uiElement [

	^TestEnvironmentUI
]

{ #category : 'execution' }
TestEnvironmentBehavior >> execute [
	^(CurrentExecutionEnvironment value isTest).

]

{ #category : 'initialization' }
TestEnvironmentBehavior >> initialize [ 
	"should be executed before once and count etc."
	super initialize.
	self priority: 50.
]
