Class {
	#name : #DebugPointTest,
	#superclass : #TestCase,
	#instVars : [
		'dp'
	],
	#category : #DebugPointTestingEnvironment
}

{ #category : #running }
DebugPointTest >> setUp [
	super setUp.
	
	"Put here a common initialization logic for tests"
	dp := DebugPoint new.
]

{ #category : #initialization }
DebugPointTest >> setUpContext [
	"set up context"
	| aCompiledMethod aReceiver aSender anArgument aMethodContext |
	aCompiledMethod := Rectangle methodDict at: #areasOutside:.
	aReceiver := 100 @ 100 corner: 200 @ 200.
	aSender := thisContext.
	anArgument := 420 @ 420 corner: 200 @ 200.
	^aMethodContext := Context
		                  sender: aSender
		                  receiver: aReceiver
		                  method: aCompiledMethod
		                  arguments: { anArgument }.
]

{ #category : #running }
DebugPointTest >> tearDown [ 
	
	dp remove.
	
	super tearDown.
]

{ #category : #running }
DebugPointTest >> testBehaviorPriority [
	| a b c set |
	a := BreakBehavior new priority: 2.
	b := CountBehavior new priority: 1.
	c := CountBehavior new priority: 3.
	dp addBehavior: a.
	dp addBehavior: b.
	dp addBehavior: c.
	set := OrderedCollection new add: c; add: a; add: b; yourself.
	self assert: (dp behaviors asOrderedCollection ) equals: set.

]

{ #category : #running }
DebugPointTest >> testBreakBehavior [

	dp addBehavior: BreakBehavior new.
	self should: [dp hit] raise: Break.
	self should: [dp hit] raise: Break.
]

{ #category : #running }
DebugPointTest >> testConditionBehavior [
	| behavior args |
	behavior := ConditionBehavior new condition: 'corner=(300@200)'.
	dp addBehavior: behavior.
	dp addBehavior: BreakBehavior new.

	args := Dictionary new at: #context put: self setUpContext; yourself.
	
	"hit the point so the arguments are actually saved in the debug point"
	dp hitWithArguments: args.
	"condition is false and should not trigger break"
	self assert: (behavior execute) equals: false.
	self shouldnt: [dp hit] raise: Break.
	"condition is false and should not trigger break"
	behavior condition: 'self corner=(300@200)'.
	self assert: (behavior execute) equals: false.
	self shouldnt: [dp hit] raise: Break.
	"condition is true and should trigger the break"
	behavior condition: 'corner=(200@200)'.
	self assert: (behavior execute) equals: behavior .
	self should: [dp hit] raise: Break.

]

{ #category : #running }
DebugPointTest >> testConditionBehaviorThisContext [
	| behavior args |

	behavior := ConditionBehavior new condition: 'thisContext method = 2'.
	dp addBehavior: behavior.
	dp addBehavior: BreakBehavior new.

	args := Dictionary new at: #context put: self setUpContext; yourself.
	
	"hit the point so the arguments are actually saved in the debug point"
	dp hitWithArguments: args.
	
	"it should not break with incorrect condition"
	self assert: (behavior execute) equals: false.
	self shouldnt: [dp hit] raise: Break.

	"here the condition is correct and it should break"
	behavior condition: 'thisContext method = (Rectangle methodDict at: #areasOutside:)'.
	self assert: (behavior execute) equals: behavior .
	self should: [dp hit] raise: Break.

]

{ #category : #running }
DebugPointTest >> testCountBehavior [

	dp addBehavior: CountBehavior new.
	self assert: ( (dp getBehavior: CountBehavior) count ) equals: 0.
	dp hit.
	self assert: ( (dp getBehavior: CountBehavior) count ) equals: 1.
	dp hit.
	self assert: ( (dp getBehavior: CountBehavior) count ) equals: 2.

]

{ #category : #running }
DebugPointTest >> testOnceBehavior [
	dp addBehavior: (OnceBehavior new).
	self assert: (dp enabled) equals: true.
	dp hit.
	self assert: (dp enabled) equals: false.


]

{ #category : #running }
DebugPointTest >> testOnceBreakBehavior [

	dp addBehavior: (BreakBehavior new).
	dp addBehavior: (OnceBehavior new).
	self assert: (dp enabled) equals: true.
	self should: [dp hit] raise: Break.
	self assert: (dp enabled) equals: false.
	self shouldnt: [dp hit] raise: Break.

]

{ #category : #running }
DebugPointTest >> testRequiredArguments [

	dp addBehavior: (ConditionBehavior new).
	dp addBehavior: TestRequiredArgumentsBehavior new.
	self assert: dp requiredArguments equals: #(context node smth) asSet.



]

{ #category : #running }
DebugPointTest >> testTranscriptBehavior [

	dp addBehavior: (TranscriptBehavior new text: 'string').
	
	dp hit.
	Transcript stepGlobal .
	self assert: Transcript contents equals: 'string'
]

{ #category : #running }
DebugPointTest >> testWatchBehavior [
	
	| wb his args | 
	wb := WatchBehavior new expression: 'corner'.
	dp addBehavior: (wb).
	his := OrderedCollection new.
	args := Dictionary new at: #context put: self setUpContext; yourself.
	
	"check empty history"
	self assert: wb history equals: his.
	"check history after hitting dp"
	dp hitWithArguments: args.
	his add: 200@200.
	self assert: wb history equals: his.
	"once more"
	wb expression: '''string'''.
	dp hitWithArguments: args.
	his addFirst: 'string'.
	self assert: wb history equals: his.
	"once more"	
	dp hitWithArguments: args.
	his addFirst: 'string'.
	self assert: wb history equals: his.
	"check if limit is applie correctly"
	wb limit: 2.
	his removeLast.
	self assert: wb history equals: his.
	"hitting does not change the history size anymore"
	dp hitWithArguments: args.
	self assert: wb history equals: his.

]
