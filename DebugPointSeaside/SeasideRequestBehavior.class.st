Class {
	#name : 'SeasideRequestBehavior',
	#superclass : 'DebugPointBehavior',
	#instVars : [
		'ip'
	],
	#category : 'DebugPointSeaside',
	#package : 'DebugPointSeaside'
}

{ #category : 'accessing' }
SeasideRequestBehavior class >> uiElement [

	^SeasideRequestUI
]

{ #category : 'initialization' }
SeasideRequestBehavior >> context [
	^self getArgument: #context
]

{ #category : 'execution' }
SeasideRequestBehavior >> execute [
	| receiver |
	receiver := self context receiver .
	(receiver isKindOf: WAObject) ifFalse: [ ^false ].
	^(receiver requestContext request remoteAddress = self ip)

]

{ #category : 'initialization' }
SeasideRequestBehavior >> initialize [ 
	"should be executed before once and count etc."
	super initialize.
	self priority: 50.
]

{ #category : 'execution' }
SeasideRequestBehavior >> ip [
	^ip ifNil: [ '' ].
]

{ #category : 'execution' }
SeasideRequestBehavior >> ip: aString [
	ip := aString
]
