Class {
	#name : #TranscriptBehavior,
	#superclass : #DebugPointBehavior,
	#instVars : [
		'text'
	],
	#category : #DebugPointImplementations
}

{ #category : #accessing }
TranscriptBehavior >> execute [ 
	Transcript show: text.
]

{ #category : #accessing }
TranscriptBehavior >> text [
	^text
]

{ #category : #accessing }
TranscriptBehavior >> text: aString [
	text := aString
]
