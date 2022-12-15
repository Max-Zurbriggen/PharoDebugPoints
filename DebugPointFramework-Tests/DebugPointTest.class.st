Class {
	#name : #DebugPointTest,
	#superclass : #TestCase,
	#instVars : [
		'dp',
		'node',
		'context'
	],
	#category : #'DebugPointFramework-Tests'
}

{ #category : #running }
DebugPointTest >> setUp [
	super setUp.
	
	"set a node to install the dp on"
	node := (DummyTestClass methods select: [ :method | method name = 'DummyTestClass>>#id:' ]) first ast.
	context := self setUpContext.
	
	
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
	dp := DebugPointManager installNew: DebugPoint On: node.
	a := OnceBehavior new priority: 2.
	b := CountBehavior new priority: 1.
	c := ChainBehavior new priority: 3.
	dp addBehavior: a.
	dp addBehavior: b.
	dp addBehavior: c.
	set := OrderedCollection new add: c; add: a; add: b; yourself.
	self assert: (dp behaviors asOrderedCollection ) equals: set.

]

{ #category : #running }
DebugPointTest >> testBreakDebugPoint [
	dp := DebugPointManager installNew: BreakDebugPoint On: node.
	self should: [dp hitWithContext: context] raise: Break.
	self should: [DummyTestClass new id:2 ] raise: Break.
]

{ #category : #running }
DebugPointTest >> testConditionBehavior [
	| behavior |
	behavior := ConditionBehavior new condition: 'corner=(300@200)'.
	dp := DebugPointManager installNew: BreakDebugPoint On: node.
	dp addBehavior: behavior.
	"dp addBehavior: BreakBehavior new."

	"hit the point so the arguments are actually saved in the debug point"
	dp hitWithContext: context.
	"condition is false and should not trigger break"
	self assert: (behavior execute) equals: false.
	self shouldnt: [dp hitWithContext: context.] raise: Break.
	"condition is false and should not trigger break"
	behavior condition: 'self corner=(300@200)'.
	self assert: (behavior execute) equals: false.
	self shouldnt: [dp hitWithContext: context.] raise: Break.
	"condition is true and should trigger the break"
	behavior condition: 'corner=(200@200)'.
	self assert: (behavior execute) equals: true .
	self should: [dp hitWithContext: context.] raise: Break.

]

{ #category : #running }
DebugPointTest >> testConditionBehaviorThisContext [
	| behavior |
	
	dp := DebugPointManager installNew: BreakDebugPoint On: node.

	behavior := ConditionBehavior new condition: 'thisContext method = 2'.
	dp addBehavior: behavior.
	
	"hit the point so the arguments are actually saved in the debug point"
	dp hitWithContext: context.
	
	"it should not break with incorrect condition"
	self assert: (behavior execute) equals: false.
	self shouldnt: [dp hitWithContext: context] raise: Break.

	"here the condition is correct and it should break"
	behavior condition: 'thisContext method = (Rectangle methodDict at: #areasOutside:)'.
	self assert: (behavior execute) equals: true .
	self should: [dp hitWithContext: context] raise: Break.

]

{ #category : #running }
DebugPointTest >> testCountBehavior [
	| cbh |
	
	dp := DebugPointManager installNew: DebugPoint  On: node withBehaviors: {CountBehavior}.
	cbh := dp getBehavior: CountBehavior.
	self assert: ( cbh count ) equals: 0.
	dp hitWithContext: context.
	self assert: ( cbh count ) equals: 1.
	dp hitWithContext: context.
	self assert:  ( cbh count ) equals: 2.

]

{ #category : #running }
DebugPointTest >> testOnceBehavior [
	dp := DebugPointManager installNew: DebugPoint On: node.
	dp addBehavior: (OnceBehavior new).
	self assert: (dp enabled) equals: true.
	dp hitWithContext: context.
	self assert: (dp enabled) equals: false.


]

{ #category : #running }
DebugPointTest >> testOnceBreakBehavior [
	dp := DebugPointManager installNew: BreakDebugPoint On: node withBehaviors: {OnceBehavior}.

	self assert: (dp enabled) equals: true.
	self should: [dp hitWithContext: context] raise: Break.
	self assert: (dp enabled) equals: false.
	self shouldnt: [dp hitWithContext: context] raise: Break.

]

{ #category : #running }
DebugPointTest >> testTranscriptDebugPoint [

	dp := DebugPointManager installNew: TranscriptDebugPoint On: node.
	dp text: 'string'.
	dp hitWithContext: context.
	Transcript stepGlobal .
	self assert: Transcript contents equals: 'string'
]

{ #category : #running }
DebugPointTest >> testWatchDebugPoint [
	| his | 
	
	dp := DebugPointManager installNew: WatchDebugPoint On: node.
	his := OrderedCollection new.

	"check empty history"
	self assert: dp history equals: his.
	"check history after hitting dp"
	DummyTestClass new id: 2.
	his add: 2.
	self assert: dp history equals: his.
	"once more"
	DummyTestClass new id: 'string'.
	his addFirst: 'string'.
	self assert: dp history equals: his.
	"once more"	
	DummyTestClass new id: 'string2'.
	his addFirst: 'string2'.
	self assert: dp history equals: his.
	"check if limit is applied correctly"
	dp limit: 2.
	his removeLast.
	self assert: dp history equals: his.
	"hitting does not change the history size anymore"
	DummyTestClass new id: 'string3'.
	his addFirst: 'string3'.
	his removeLast.
	self assert: dp history equals: his.

]
