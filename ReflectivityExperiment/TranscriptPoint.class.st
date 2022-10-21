Class {
	#name : #TranscriptPoint,
	#superclass : #DebugPoint,
	#instVars : [
		'text'
	],
	#classVars : [
		'AllScriptExecutors'
	],
	#category : #ReflectivityExperiment
}

{ #category : #accessing }
TranscriptPoint >> hit [
	Transcript show: text
]

{ #category : #accessing }
TranscriptPoint >> initialize [ 
	super initialize. 
	text:= ''.
	text := self newTextPopup.
]

{ #category : #accessing }
TranscriptPoint >> newTextPopup [

	| textInput |
	textInput := SpRequestTextDialog new
		label: 'Enter text to print to transcript:';
		text: '';
		title: 'Enter text';
		openModal.
	textInput ifNil: [ ^'' ].
	^textInput 
]

{ #category : #accessing }
TranscriptPoint >> text: aString [
	text := aString
]
