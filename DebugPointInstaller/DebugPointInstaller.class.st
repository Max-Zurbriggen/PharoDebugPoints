Class {
	#name : #DebugPointInstaller,
	#superclass : #Object,
	#category : #DebugPointInstaller
}

{ #category : #'as yet unclassified' }
DebugPointInstaller class >> install: aDebugPointClass On: aNode [

	self install: aDebugPointClass On: aNode withBehaviors: {  }.
]

{ #category : #'as yet unclassified' }
DebugPointInstaller class >> install: aDebugPointClass On: aNode withBehaviors: aListOfBehaviorClasses [
	| dp ml |

	dp := aDebugPointClass new node: aNode.

	"adding behaviors"	
	aListOfBehaviorClasses do: [ :bhc | dp addBehavior: bhc new].
	
	ml := dp metaLink.

	dp link: ml.
	aNode link: ml.
	DebugPointManager new open.
]
