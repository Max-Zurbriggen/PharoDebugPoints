Class {
	#name : #BreakDebugPoint,
	#superclass : #DebugPoint,
	#category : #DebugPointImplementations
}

{ #category : #execution }
BreakDebugPoint >> hitWithContext: aContext [
	<debuggerCompleteToSender>
	
	super hitWithContext: aContext.
	
	Break break.
]

{ #category : #accessing }
BreakDebugPoint >> uiElement [ 
	^SpLabelPresenter new label: 'Break'.
]
