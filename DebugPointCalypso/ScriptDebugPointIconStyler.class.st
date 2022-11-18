Class {
	#name : #ScriptDebugPointIconStyler,
	#superclass : #DebugPointIconStyler,
	#category : #DebugPointCalypso
}

{ #category : #defaults }
ScriptDebugPointIconStyler >> forClass [
	^ScriptDebugPoint 
]

{ #category : #defaults }
ScriptDebugPointIconStyler >> iconLabel: aNode [
	^ 'Script'
]
