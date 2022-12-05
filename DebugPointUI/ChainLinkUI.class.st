Class {
	#name : #ChainLinkUI,
	#superclass : #DebugPointBehaviorUI,
	#instVars : [
		'chain'
	],
	#category : #DebugPointUI
}

{ #category : #accessing }
ChainLinkUI >> debugPoint: aDebugPoint [
	super debugPoint: aDebugPoint.
	behavior := self debugPoint getBehavior: ChainBehavior.
	checkBox state: (self debugPoint getBehavior: ChainBehavior) isNotNil.
	behavior ifNotNil: [ 

	chain roots: (ChainBehavior rootFor: aDebugPoint) asOrderedCollection .
	chain children: [ :dp | (ChainBehavior childFor: dp) ifNil:[OrderedCollection new] ifNotNil: [:dp2 | { dp2 } ]].
	"chain expandAll."
	"since selectItem does not work after expanding this requires a different solution to clarify which chainlink is currently selected"
	"chain selectItem: aDebugPoint."
].
]

{ #category : #layout }
ChainLinkUI >> defaultLayout [ 
	| newLayout |
	
	newLayout := SpBoxLayout newTopToBottom 
		
		add: checkBox expand: false;
		yourself.
		
	self behavior ifNotNil: [
		newLayout add: ( SpBoxLayout newLeftToRight borderWidth: 5;
			"add: (self newLabel label: 'Text:') expand: false ;"
			add: (self newButton label: 'Reset'; action: [self resetChain.]) expand: false;
			yourself) expand: false;
		add: chain  "expand: true" height: 100 ;
		yourself].
		
	^newLayout
	

		

]

{ #category : #accessing }
ChainLinkUI >> findChildren: aDebugPoint [
	
	^(aDebugPoint getBehavior: ChainBehavior ) ifNotNil: [ 
	(aDebugPoint getBehavior: ChainBehavior ) childrenDebugPoints ] "ifFalse: [ OrderedCollection new. ]"
]

{ #category : #initialization }
ChainLinkUI >> initializePresenters [ 
	
	chain := self newTreeTable.
	checkBox  := self newCheckBox label: 'Chain'.
	checkBox whenActivatedDo: [ self behavior ifNil: [ debugPoint addBehavior: ChainBehavior new ] ].
	checkBox whenDeactivatedDo: [ 
		self debugPoint removeBehavior: ChainBehavior. 
		self behavior: nil. ].
]

{ #category : #layout }
ChainLinkUI >> resetChain [

	self debugPoint resetChain.
]
