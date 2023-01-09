Class {
	#name : #SeasideRequestBehavior,
	#superclass : #DebugPointBehavior,
	#instVars : [
		'ip'
	],
	#category : #'DebugPointFramework-Behaviors'
}

{ #category : #accessing }
SeasideRequestBehavior class >> uiElement [

	^SeasideRequestUI
]

{ #category : #initialization }
SeasideRequestBehavior >> context [
	^self getArgument: #context
]

{ #category : #execution }
SeasideRequestBehavior >> execute [

	(self request remoteAddress = self ip) ifFalse: [ ^false ].
	^true

]

{ #category : #initialization }
SeasideRequestBehavior >> initialize [ 
	"should be executed before once and count etc."
	super initialize.
	self priority: 50.
]

{ #category : #execution }
SeasideRequestBehavior >> ip [
	^ip ifNil: [ '' ].
]

{ #category : #execution }
SeasideRequestBehavior >> ip: aString [
	ip := aString
]

{ #category : #execution }
SeasideRequestBehavior >> request [ 
	^self context receiver requestContext request
]
