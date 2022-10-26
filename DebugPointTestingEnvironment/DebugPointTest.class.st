Class {
	#name : #DebugPointTest,
	#superclass : #TestCase,
	#category : #DebugPointTestingEnvironment
}

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
