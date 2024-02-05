"
I am the base for DebugPoint Announcements that are required to update UIs.
"
Class {
	#name : 'DebugPointAnnouncement',
	#superclass : 'SystemAnnouncement',
	#instVars : [
		'debugPoint',
		'nodes'
	],
	#category : 'DebugPointFramework-Announcements',
	#package : 'DebugPointFramework',
	#tag : 'Announcements'
}

{ #category : 'instance creation' }
DebugPointAnnouncement class >> on: aDebugPoint nodes: nodes [
	^ self new
		debugPoint: aDebugPoint;
		nodes: nodes;
		yourself
]

{ #category : 'accessing' }
DebugPointAnnouncement >> affectsMethod: aMethod [

	^ self methods anySatisfy: [:each |  each compiledMethod == aMethod compiledMethod.  ]
]

{ #category : 'accessing' }
DebugPointAnnouncement >> affectsMethods [
	^true
]

{ #category : 'accessing' }
DebugPointAnnouncement >> affectsMethodsDefinedInClass: aClass [
	^ self methods
		anySatisfy: [ :each | each methodClass isNotNil and: [ each origin == aClass ] ]
]

{ #category : 'accessing' }
DebugPointAnnouncement >> affectsMethodsDefinedInPackage: aPackage [
	^ self methods
		anySatisfy:
			[ :each | each methodClass isNotNil and: [ each package == aPackage ] ]
]

{ #category : 'accessing' }
DebugPointAnnouncement >> canAffectResultOfMethodQuery: aMethodQuery [

	^ self methods anySatisfy: [:each | 
		aMethodQuery isAffectedByChangedMethod: each ]
]

{ #category : 'accessing' }
DebugPointAnnouncement >> debugPoint [
	^debugPoint 
]

{ #category : 'accessing' }
DebugPointAnnouncement >> debugPoint: aDebugPoint [
	debugPoint := aDebugPoint 
]

{ #category : 'accessing' }
DebugPointAnnouncement >> methods [
	^nodes flatCollect: [ :entity |
		(entity isKindOf: RBProgramNode) 
			ifTrue: [ {entity methodNode compiledMethod}  ]
			ifFalse: [ entity usingMethods ] ]
]

{ #category : 'accessing' }
DebugPointAnnouncement >> nodes [
	^nodes
]

{ #category : 'accessing' }
DebugPointAnnouncement >> nodes: someNodes [
	nodes := someNodes 
]
