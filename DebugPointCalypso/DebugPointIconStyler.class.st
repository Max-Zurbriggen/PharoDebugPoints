"
All of my subclasses are automatically styled.
"
Class {
	#name : #DebugPointIconStyler,
	#superclass : #IconStyler,
	#category : #DebugPointCalypso
}

{ #category : #defaults }
DebugPointIconStyler >> addIconStyle: aNode from: start to: stop color: aColor [
	"there probably is a better way that just adding a second row but i couldn't figure out rubric"
	| conf |
	(self shouldStyleNode: aNode) ifFalse: [ ^ self ].
	conf := RubConfigurationChange new.
	conf configurationBlock: [ :text | 
		| r r2 |
		r := self segmentMorphClass from: start to: stop + 1.
		text addSegment: r.
		r label: (self iconLabelBlock: aNode).
		r icon: (self iconFor: aNode).
		r iconBlock: (self iconBlock: aNode).
		r color: aColor.
		r borderColor: self borderColor .
		r2 := self segmentMorphClass from: start to: stop + 1.
		text addSegment: r2.
		r2 label: 'Remove'.
		r2 icon: (self iconFor: aNode).
		r2 iconBlock: (self iconBlockEdit: aNode).
		r2 color: aColor.
		r2 borderColor: self borderColor .
		].
	
	textModel announce: conf
]

{ #category : #'as yet unclassified' }
DebugPointIconStyler >> debugPointOn: aNode [
	^(aNode links detect: [ :link | link metaObject isKindOf: self forClass ]) metaObject.
]

{ #category : #defaults }
DebugPointIconStyler >> disableIcon: anIcon onNode: aNode [

	(self debugPointOn: aNode) enabled ifFalse: [
		^anIcon dimmed
		"in case i want it crossed out when disabled:"
		"^anIcon mergeWith: (self iconNamed: #smallCancel)"
		].
	
	^anIcon
]

{ #category : #'as yet unclassified' }
DebugPointIconStyler >> forClass [
	^DebugPoint
]

{ #category : #defaults }
DebugPointIconStyler >> hasBehaviorIcon: anIcon onNode: aNode [

	((self debugPointOn: aNode) behaviors ) ifNotEmpty: [ ^anIcon mergeWith: (((self iconNamed: #smallCogInitialState)scaledToSize: 9@9)darker: 1 ) at: 8@0 ].
	^anIcon
	
	"in case i want seperate things for each behavior:"
	
"	|rec|
	rec := Rectangle origin: 8@0 extent: 8@8.
	((self debugPointOn: aNode) getBehavior: OnceBehavior ) ifNotNil: [
		^anIcon mergeWith: ((self iconNamed: #smallCogInitialState)scaledToSize: 9@9 ) at: 8@0
		^anIcon fill: rec fillColor: (Color r: 0 g: 0.0 b: 1 )
		]."
	
"	((self debugPointOn: aNode) getBehavior: ConditionBehavior) ifNotNil: [
		^anIcon mergeWith: ((self iconNamed: #class)scaledToSize: 8@8 ) at: 8@8
		]."
]

{ #category : #defaults }
DebugPointIconStyler >> highlightColor [
	^(Color yellow alpha: 0.3)
]

{ #category : #defaults }
DebugPointIconStyler >> icon [
	
	^ self iconNamed: #smallDebug
]

{ #category : #defaults }
DebugPointIconStyler >> iconBlock: aNode [

	^[ :seg | DebugPointManagerUI new open; select: (self debugPointOn: aNode). ]

]

{ #category : #defaults }
DebugPointIconStyler >> iconBlockEdit: aNode [
		 ^ [ :seg | (self debugPointOn: aNode) remove.
	   seg delete ]
]

{ #category : #defaults }
DebugPointIconStyler >> iconFor: aNode [
	| icon |
	icon := self icon deepCopy.	
	icon := self hasBehaviorIcon: icon onNode: aNode.
	icon := self disableIcon: icon onNode: aNode.

	^ icon
]

{ #category : #defaults }
DebugPointIconStyler >> iconLabel: aNode [
	^ 'DebugPoint'
]

{ #category : #testing }
DebugPointIconStyler >> shouldStyleNode: aNode [
	^aNode hasDebugPointOfType: self forClass
]
