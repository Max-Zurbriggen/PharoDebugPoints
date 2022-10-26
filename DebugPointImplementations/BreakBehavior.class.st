Class {
	#name : #BreakBehavior,
	#superclass : #DebugPointBehavior,
	#category : #DebugPointImplementations
}

{ #category : #execution }
BreakBehavior >> execute [
	<debuggerCompleteToSender>
	Break break.
]

{ #category : #initialization }
BreakBehavior >> initialize [
	"breaking should always occur at the end so assign the lowest priority to this"
	self priority: -100
]
