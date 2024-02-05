"
I am the UI element for a breakpoint.
"
Class {
	#name : 'BreakUI',
	#superclass : 'DebugPointUI',
	#category : 'DebugPointUI',
	#package : 'DebugPointUI'
}

{ #category : 'layout' }
BreakUI >> defaultLayout [ 
	
	^SpBoxLayout newTopToBottom 
		add: (self newLabel label: 'Break') expand: false ;
		yourself.
		

]
