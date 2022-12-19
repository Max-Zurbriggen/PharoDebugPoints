Class {
	#name : #BreakUI,
	#superclass : #DebugPointUI,
	#category : #DebugPointUI
}

{ #category : #layout }
BreakUI >> defaultLayout [ 
	
	^SpBoxLayout newTopToBottom 
		add: (self newLabel label: 'Break') expand: false ;
		yourself.
		

]
