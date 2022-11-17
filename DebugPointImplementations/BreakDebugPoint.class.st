Class {
	#name : #BreakDebugPoint,
	#superclass : #DebugPoint,
	#category : #DebugPointImplementations
}

{ #category : #execution }
BreakDebugPoint >> hitWithContext: aContext [
	<debuggerCompleteToSender>
	
	(super hitWithContext: aContext) ifFalse: [^self].
	
	Break break.
]

{ #category : #accessing }
BreakDebugPoint >> name [
	^#Breakpoint
]

{ #category : #accessing }
BreakDebugPoint >> uiElement [ 
	^SpLabelPresenter new label: 'Break'.
]
