Class {
	#name : #ChainLinkDebugPointIconStyler,
	#superclass : #DebugPointIconStyler,
	#category : #DebugPointCalypso
}

{ #category : #asserting }
ChainLinkDebugPointIconStyler >> forClass [
	^ChainLinkDebugPoint 
]

{ #category : #asserting }
ChainLinkDebugPointIconStyler >> icon [
	
	^ self iconNamed: #smallDebug
]

{ #category : #defaults }
ChainLinkDebugPointIconStyler >> iconLabel: aNode [

	^ 'Chain Link'
]
