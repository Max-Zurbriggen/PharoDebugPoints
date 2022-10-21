Class {
	#name : #SimpleBreakpoint,
	#superclass : #DebugPoint,
	#instVars : [
		'once'
	],
	#category : #ReflectivityExperiment
}

{ #category : #accessing }
SimpleBreakpoint >> hit [
	<debuggerCompleteToSender>
	self once ifTrue: [ self enabled: false ].
	Break break.
]

{ #category : #accessing }
SimpleBreakpoint >> once [
	^once
]

{ #category : #accessing }
SimpleBreakpoint >> once: aBoolean [
	once:= aBoolean
]
