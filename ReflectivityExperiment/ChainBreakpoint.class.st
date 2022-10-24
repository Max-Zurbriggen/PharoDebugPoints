Class {
	#name : #ChainBreakpoint,
	#superclass : #DebugPoint,
	#instVars : [
		'followingPoints',
		'entryPoint'
	],
	#category : #ReflectivityExperiment
}

{ #category : #initialization }
ChainBreakpoint class >> resetChains [
	(self allDebugPoints select: [ :dp | dp class = ChainBreakpoint  ]) do: [ :cbp | cbp entryPoint ifTrue: [cbp enabled: true ] ifFalse: [cbp enabled: false ]]
]

{ #category : #accessing }
ChainBreakpoint >> addFollowingPoint: aDebugPoint [
	self followingPoints add: aDebugPoint 
]

{ #category : #accessing }
ChainBreakpoint >> entryPoint [
	^entryPoint ifNil: [ entryPoint := true ]
]

{ #category : #accessing }
ChainBreakpoint >> entryPoint: aBoolean [
	entryPoint:= aBoolean
]

{ #category : #accessing }
ChainBreakpoint >> followingPoints [
	^followingPoints ifNil: [ followingPoints := WeakSet new ]
]

{ #category : #accessing }
ChainBreakpoint >> hit [
	<debuggerCompleteToSender>
	self enabled: false.
	self followingPoints do: [ :bp | bp enable ].
	Break break.
	
]

{ #category : #accessing }
ChainBreakpoint >> removeFollowingPoint: aDebugPoint [
	self followingPoints remove: aDebugPoint ifAbsent: [].
]
