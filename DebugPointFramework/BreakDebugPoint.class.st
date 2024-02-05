"
I am a debug point that breaks when it is hit.
"
Class {
	#name : 'BreakDebugPoint',
	#superclass : 'DebugPoint',
	#category : 'DebugPointFramework-Implementations',
	#package : 'DebugPointFramework',
	#tag : 'Implementations'
}

{ #category : 'API' }
BreakDebugPoint >> hitWithContext: aContext [
	<debuggerCompleteToSender>
	
	(super hitWithContext: aContext) ifFalse: [^self].

	Break break.
]

{ #category : 'accessing' }
BreakDebugPoint >> name [
	^name ifNil: [ #Breakpoint ]
]

{ #category : 'accessing' }
BreakDebugPoint >> uiElement [ 
	^BreakUI new debugPoint: self.
]
