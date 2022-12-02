Class {
	#name : #ChainLinkUI,
	#superclass : #DebugPointUI,
	#instVars : [
		'chain'
	],
	#category : #DebugPointUI
}

{ #category : #accessing }
ChainLinkUI >> debugPoint: aDebugPoint [
	super debugPoint: aDebugPoint.
	
	chain roots: (aDebugPoint findRoot) asOrderedCollection ;
	 children: [ :dp | (self findChildren: dp) asOrderedCollection ];
	 expandAll.
	"since selectItem does not work after expanding this requires a different solution to clarify which chainlink is currently selected"
	chain selectItem: aDebugPoint.

]

{ #category : #layout }
ChainLinkUI >> defaultLayout [ 
	
	^SpBoxLayout newTopToBottom 
		
		add: ( SpBoxLayout newLeftToRight borderWidth: 5;
			"add: (self newLabel label: 'Text:') expand: false ;"
			add: (self newLabel label: 'Chain') expand: false ;
			add: (self newButton label: 'Reset'; action: [self resetChain.]) expand: false;
			yourself) expand: false;
		add: chain  expand: true fill: true ;
		yourself.
		

]

{ #category : #accessing }
ChainLinkUI >> findChildren: aDebugPoint [
	
	^(aDebugPoint class = ChainLinkDebugPoint ) ifTrue: [ 
	aDebugPoint  childrenDebugPoints ] ifFalse: [ OrderedCollection new. ]
]

{ #category : #initialization }
ChainLinkUI >> initializePresenters [ 
	
	chain := self newTreeTable.

]

{ #category : #layout }
ChainLinkUI >> resetChain [

	self debugPoint resetChain.
]
