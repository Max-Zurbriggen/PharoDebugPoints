"
I am a debug point which writes something with Transcript when hit.
"
Class {
	#name : #TranscriptDebugPoint,
	#superclass : #DebugPoint,
	#instVars : [
		'text'
	],
	#category : #DebugPointImplementations
}

{ #category : #execution }
TranscriptDebugPoint >> hitWithContext: aContext [
	<debuggerCompleteToSender>
	
	(super hitWithContext: aContext) ifFalse: [^self].

	Transcript show: self text.
]

{ #category : #accessing }
TranscriptDebugPoint >> name [
	^#Transcript
]

{ #category : #accessing }
TranscriptDebugPoint >> text [
	^text ifNil: [ '' ]
]

{ #category : #accessing }
TranscriptDebugPoint >> text: aString [
	text := aString.

]

{ #category : #'ui building' }
TranscriptDebugPoint >> uiElement [

	^TranscriptUI new debugPoint: self.
]
