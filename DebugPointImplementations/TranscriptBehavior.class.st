Class {
	#name : #TranscriptBehavior,
	#superclass : #DebugPointBehavior,
	#instVars : [
		'text'
	],
	#category : #DebugPointImplementations
}

{ #category : #execution }
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

{ #category : #accessing }
TranscriptBehavior >> uiElement [

	^TranscriptUI new behavior: self.
]
