Class {
	#name : #DebugPoint,
	#superclass : #Object,
	#instVars : [
		'node',
		'link',
		'enabled',
		'targetInstance',
		'key'
	],
	#classVars : [
		'AllDebugPoints'
	],
	#category : #ReflectivityExperiment
}

{ #category : #'accessing - instances and variables' }
DebugPoint class >> allDebugPoints [
	
	^ AllDebugPoints ifNil: [ AllDebugPoints := WeakOrderedCollection new ].
]

{ #category : #'accessing - instances and variables' }
DebugPoint class >> allOfThisClass [ 
	^self allDebugPoints select: [ :p | p class = self ].

]

{ #category : #'class initialization' }
DebugPoint class >> handleClassRemoved: anAnnouncement [
	self allDebugPoints copy do: [ :breakpoint |
		breakpoint link methods
			detect: [ :m | m methodClass = anAnnouncement classRemoved ]
			ifFound: [ self allDebugPoints remove: breakpoint ] ]
]

{ #category : #'class initialization' }
DebugPoint class >> handleMethodModified: anAnnouncement [
	self removeFromMethod: anAnnouncement oldMethod
]

{ #category : #'class initialization' }
DebugPoint class >> handleMethodRemoved: anAnnouncement [
	self removeFromMethod: anAnnouncement method
]

{ #category : #'class initialization' }
DebugPoint class >> initialize [
	self registerInterestToSystemAnnouncement
]

{ #category : #'class initialization' }
DebugPoint class >> installOn: aRBProgramNode [
	^self new
		node: aRBProgramNode;
		install.
]

{ #category : #testing }
DebugPoint class >> isAbstract [
		
	^ self == DebugPoint
]

{ #category : #'class initialization' }
DebugPoint class >> registerInterestToSystemAnnouncement [
	<systemEventRegistration>

	SystemAnnouncer uniqueInstance unsubscribe: self.
	SystemAnnouncer uniqueInstance weak when: MethodRemoved send: #handleMethodRemoved: to: self.
	SystemAnnouncer uniqueInstance weak when: MethodModified send: #handleMethodModified: to: self.
	SystemAnnouncer uniqueInstance weak when: ClassRemoved send: #handleClassRemoved: to: self
]

{ #category : #'class initialization' }
DebugPoint class >> removeAllDebugPoints [
	self allDebugPoints do: [ :aWatchpoint| aWatchpoint uninstall].
	AllDebugPoints := nil.
]

{ #category : #testing }
DebugPoint class >> removeFromMethod: aMethod [ 
	self allDebugPoints copy do: [ :point |
		point link methods
			detect: [ :m | m == aMethod ]
			ifFound: [ point uninstall] ]
]

{ #category : #'class initialization' }
DebugPoint class >> withKey: aKey [
	"returns the DebugPoint with aKey, there should only be 1 debugpoint with each key"
	^(self allDebugPoints select: [ :dp | dp key = aKey ]) first.
]

{ #category : #accessing }
DebugPoint >> createLink [

	^MetaLink new 
				metaObject: self;
				selector: #hit;
				options: #(+ optionAnnounce).
]

{ #category : #accessing }
DebugPoint >> enabled [ 
	^enabled
]

{ #category : #accessing }
DebugPoint >> enabled: aBoolean [
	"not nice but there is no api on metalinks for this and they break if you enable them without having a condition"
	aBoolean ifTrue: [ self link condition ifNotNil: [self link enable] ] ifFalse: [ self link disable ]. 
	enabled := aBoolean 
]

{ #category : #accessing }
DebugPoint >> hit [
	<debuggerCompleteToSender>
	"this is the method that is called by the metalinks, should be implemented by the subclasses or a different method can be set on the metalinks by overwriting the createLink Method"
	^self
	
]

{ #category : #accessing }
DebugPoint >> initialize [
	super initialize.
	key := self hash.
]

{ #category : #accessing }
DebugPoint >> install [

	link := self createLink.
	node link: link.
	self enabled: true.
	self class allDebugPoints add: self.
]

{ #category : #accessing }
DebugPoint >> key [
	^ key
]

{ #category : #accessing }
DebugPoint >> link [
	^ link
]

{ #category : #accessing }
DebugPoint >> node [
	^ node
]

{ #category : #accessing }
DebugPoint >> node: anObject [
	node := anObject
]

{ #category : #accessing }
DebugPoint >> printTarget [
	^node methodNode method printString
]

{ #category : #API }
DebugPoint >> resetObjectScope [
	self targetInstance: nil.
	self link condition: nil arguments: nil 

]

{ #category : #API }
DebugPoint >> setObjectScope: anObject [
	anObject ifNil: [ ^self resetObjectScope ].
	self targetInstance: anObject.
 	self link condition: [ :ctx | ctx receiver == targetInstance ] arguments: #(context)

]

{ #category : #accessing }
DebugPoint >> targetInstance [

	^targetInstance 
]

{ #category : #accessing }
DebugPoint >> targetInstance: anObject [

	targetInstance := anObject 
]

{ #category : #accessing }
DebugPoint >> uninstall [
	(node hasDebugPointOfClass: self class) ifFalse: [ ^self ].
	link uninstall.
	self class allDebugPoints remove: self ifAbsent: [].
]
