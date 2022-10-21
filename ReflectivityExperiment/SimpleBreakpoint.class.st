Class {
	#name : #SimpleBreakpoint,
	#superclass : #DebugPoint,
	#category : #ReflectivityExperiment
}

{ #category : #accessing }
SimpleBreakpoint >> hit [
	<debuggerCompleteToSender>
	Break break.
]
