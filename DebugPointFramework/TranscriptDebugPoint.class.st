"
I am a debug point which writes something with Transcript when hit.
"
Class {
	#name : #TranscriptDebugPoint,
	#superclass : #DebugPoint,
	#category : #'DebugPointFramework-Implementations'
}

{ #category : #accessing }
TranscriptDebugPoint >> initialize [ 
	super initialize.
	
	self behaviors add: (TranscriptBehavior new debugPoint: self).
	(self getBehavior: TranscriptBehavior) text: self popUp.
]

{ #category : #accessing }
TranscriptDebugPoint >> name [
	^name ifNil: [ #Transcript ]

]

{ #category : #accessing }
TranscriptDebugPoint >> popUp [
	|textInput|
	textInput := SpRequestDialog new
		label: 'Enter string:';
		text: '';
		title: 'Transcript String';
		openModal.
	textInput ifNil: [ ^'' ].
	^textInput 
]

{ #category : #accessing }
TranscriptDebugPoint >> text [
	^(self getBehavior: TranscriptBehavior) ifNotNil: [ :bh | bh text ] ifNil: [ '' ].

]
