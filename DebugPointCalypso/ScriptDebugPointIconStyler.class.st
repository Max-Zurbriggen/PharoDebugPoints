Class {
	#name : #ScriptDebugPointIconStyler,
	#superclass : #DebugPointIconStyler,
	#category : #DebugPointCalypso
}

{ #category : #defaults }
ScriptDebugPointIconStyler >> debugPointOn: aNode [
	^(aNode links detect: [ :link | link metaObject class = ScriptDebugPoint ]) metaObject.
]

{ #category : #defaults }
ScriptDebugPointIconStyler >> iconLabel: aNode [
	^ 'Script'
]

{ #category : #asserting }
ScriptDebugPointIconStyler >> shouldStyleNode: aNode [
	^aNode hasDebugPointOfType: ScriptDebugPoint
]
