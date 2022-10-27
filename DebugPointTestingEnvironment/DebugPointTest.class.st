Class {
	#name : #DebugPointTest,
	#superclass : #TestCase,
	#category : #DebugPointTestingEnvironment
}

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
DebugPointTest >> testBehaviorPriority [
	| dp a b c set |
	dp := DebugPoint new.
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
	| dp |
	dp := DebugPoint new.
	dp addBehavior: BreakBehavior new.
	self should: [dp hit] raise: Break.
	self should: [dp hit] raise: Break.
]

{ #category : #running }
DebugPointTest >> testConditionBehavior [
	| dp behavior args |
	dp := DebugPoint new.
	behavior := ConditionBehavior new debugPoint: dp; condition: 'corner=(300@200)'.
	dp addBehavior: behavior.
	dp addBehavior: BreakBehavior new.

	args := Dictionary new at: #context put: self setUpContext; yourself.
	
	"hit the point so the arguments are actually saved in the debug point"
	dp hitWithArguments: args.
	
	self assert: (behavior execute) equals: false.
	self shouldnt: [dp hit] raise: Break.
	
	behavior condition: 'self corner=(300@200)'.
	self assert: (behavior execute) equals: false.
	self shouldnt: [dp hit] raise: Break.
	
	behavior condition: 'corner=(200@200)'.
	self assert: (behavior execute) equals: behavior .
	self should: [dp hit] raise: Break.

]

{ #category : #running }
DebugPointTest >> testCountBehavior [
	| dp |
	dp := DebugPoint new.
	dp addBehavior: CountBehavior new.
	self assert: ( (dp getBehavior: CountBehavior) count ) equals: 0.
	dp hit.
	self assert: ( (dp getBehavior: CountBehavior) count ) equals: 1.
	dp hit.
	self assert: ( (dp getBehavior: CountBehavior) count ) equals: 2.

]

{ #category : #running }
DebugPointTest >> testOnceBehavior [
	| dp |
	dp := DebugPoint new.
	dp addBehavior: (OnceBehavior new debugPoint: dp).
	self assert: (dp enabled) equals: true.
	dp hit.
	self assert: (dp enabled) equals: false.

]

{ #category : #running }
DebugPointTest >> testOnceBreakBehavior [
	| dp |
	dp := DebugPoint new.
	dp addBehavior: (BreakBehavior new).
	dp addBehavior: (OnceBehavior new debugPoint: dp).
	self assert: (dp enabled) equals: true.
	self should: [dp hit] raise: Break.
	self assert: (dp enabled) equals: false.
	self shouldnt: [dp hit] raise: Break.

]

{ #category : #running }
DebugPointTest >> testRequiredArguments [
	| dp |
	dp := DebugPoint new.
	dp addBehavior: (ConditionBehavior new).
	dp addBehavior: TestRequiredArgumentsBehavior new.
	self assert: dp requiredArguments equals: #(context node smth) asSet.



]

{ #category : #running }
DebugPointTest >> testTranscriptBehavior [

	| dp |
	dp := DebugPoint new.
	dp addBehavior: (TranscriptBehavior new text: 'string').
	dp hit.
	self assert: Transcript contents equals: 'string'
]
