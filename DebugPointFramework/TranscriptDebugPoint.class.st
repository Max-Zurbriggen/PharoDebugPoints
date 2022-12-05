"
I am a debug point which writes something with Transcript when hit.
"
Class {
	#name : #TranscriptDebugPoint,
	#superclass : #DebugPoint,
	#instVars : [
		'text'
	],
	#category : #'DebugPointFramework-Implementations'
}

{ #category : #API }
TranscriptDebugPoint >> hitWithContext: aContext [
	
	(super hitWithContext: aContext) ifFalse: [^self].

	Transcript show: self text.
]

{ #category : #accessing }
TranscriptDebugPoint >> name [
	^name ifNil: [ #Transcript ]

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
