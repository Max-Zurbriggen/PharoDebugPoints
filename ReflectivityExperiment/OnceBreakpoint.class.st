Class {
	#name : #OnceBreakpoint,
	#superclass : #DebugPoint,
	#category : #ReflectivityExperiment
}

{ #category : #accessing }
OnceBreakpoint >> hit [
	<debuggerCompleteToSender>
	self enabled: false.
	Break break.
	
]
