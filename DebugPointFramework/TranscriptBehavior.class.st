Class {
	#name : #TranscriptBehavior,
	#superclass : #DebugPointBehavior,
	#instVars : [
		'text'
	],
	#category : #'DebugPointFramework-Behaviors'
}

{ #category : #'ui building' }
TranscriptBehavior class >> uiElement [

	^TranscriptUI
]

{ #category : #API }
TranscriptBehavior >> execute [
	
	Transcript show: self text.
	
	^true
]

{ #category : #accessing }
TranscriptBehavior >> remove [ 
	"saving the text in case the behavior is added again later"
	self debugPoint properties at: #TranscriptText put: self text.
]

{ #category : #accessing }
TranscriptBehavior >> text [
	^text ifNil: [ '' ]
]

{ #category : #accessing }
TranscriptBehavior >> text: aString [
	text := aString.

]
