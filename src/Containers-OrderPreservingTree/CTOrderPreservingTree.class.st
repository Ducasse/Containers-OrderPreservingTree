Class {
	#name : #CTOrderPreservingTree,
	#superclass : #Object,
	#instVars : [
		'parent'
	],
	#category : #'Containers-OrderPreservingTree'
}

{ #category : #accessing }
CTOrderPreservingTree >> asArray [

	^ Array streamContents: [ :aStream | 
		  self do: [ :each | aStream nextPut: each ] ]
]

{ #category : #enumerating }
CTOrderPreservingTree >> associationsDo: aBlock [

	self do: [ :each | 
		parent
			at: each
			ifPresent: [ :anAssoc | aBlock value: anAssoc key -> each ] ]
]

{ #category : #accessing }
CTOrderPreservingTree >> children [

	^ self children: [ :anAssoc | anAssoc key ]
]

{ #category : #accessing }
CTOrderPreservingTree >> children: aBlock [

	| child |
	child := IdentityDictionary new.

	parent keysAndValuesDo: [ :aChild :anAssoc | 
		| children |
		children := child
			            at: anAssoc key
			            ifAbsentPut: [ self newCollection ].

		anAssoc key ~~ aChild ifTrue: [ 
			children add: aChild -> anAssoc value ].

		child at: aChild ifAbsentPut: [ self newCollection ] ].

	child keysDo: [ :each | 
		| children |
		children := (child at: each) collect: aBlock as: Array.

		child at: each put: children ].

	^ child
]

{ #category : #accessing }
CTOrderPreservingTree >> childrenWithIndexes [

	^ self children: [ :each | each ]
]

{ #category : #enumerating }
CTOrderPreservingTree >> do: aBlock [

	self pre: aBlock post: [ :anObj |  ]
]

{ #category : #initialization }
CTOrderPreservingTree >> initialize [

	super initialize.

	parent := IdentityDictionary new
]

{ #category : #testing }
CTOrderPreservingTree >> isEmpty [

	^ self size isZero
]

{ #category : #accessing }
CTOrderPreservingTree >> leaves [

	| children |
	children := self children.

	^ Array streamContents: [ :aStream | 
		  self do: [ :each | 
			  (children at: each) ifEmpty: [ aStream nextPut: each ] ] ]
]

{ #category : #accessing }
CTOrderPreservingTree >> newCollection [

	^ SortedCollection sortUsing: [ :assoc :anotherAssoc | 
		  assoc value < anotherAssoc value ]
]

{ #category : #accessing }
CTOrderPreservingTree >> parent: aParent child: aChild [

	parent
		at: aChild
		ifPresent: [ :anAssoc | 
		aParent == anAssoc key ifFalse: [ Error signal ] ]
		ifAbsentPut: [ 
			| order |
			order := parent size + 1.
			aParent -> order ]
]

{ #category : #accessing }
CTOrderPreservingTree >> parent: aParent children: aCollection [

	aCollection do: [ :each | self parent: aParent child: each ]
]

{ #category : #accessing }
CTOrderPreservingTree >> parent: aChild ifAbsent: aBlock [

	^ parent
		  at: aChild
		  ifPresent: [ :anAssoc | anAssoc key ]
		  ifAbsent: aBlock
]

{ #category : #accessing }
CTOrderPreservingTree >> parents [

	| allParents |
	allParents := IdentityDictionary new.

	parent keysAndValuesDo: [ :aChild :anAssoc | 
		allParents at: aChild put: anAssoc key ].

	^ allParents
]

{ #category : #enumerating }
CTOrderPreservingTree >> pre: preBlock post: postBlock [

	self roots do: [ :aRoot | 
		self
			pre: preBlock
			post: postBlock
			parent: aRoot
			allChildren: self children
			level: 0 ]
]

{ #category : #enumerating }
CTOrderPreservingTree >> pre: preBlock post: postBlock parent: aParent allChildren: children level: aLevel [

	| carry |
	carry := preBlock cull: aParent cull: aLevel.

	(children at: aParent) do: [ :aChild | 
		self
			pre: preBlock
			post: postBlock
			parent: aChild
			allChildren: children
			level: aLevel + 1 ].

	postBlock cull: aParent cull: carry cull: aLevel
]

{ #category : #enumerating }
CTOrderPreservingTree >> pre: preBlock post: postBlock withIndex: anIndex parent: aParent allChildren: children [

	| carry |
	carry := preBlock value: aParent value: anIndex.

	(children at: aParent) do: [ :anAssoc | 
		self
			pre: preBlock
			post: postBlock
			withIndex: anAssoc value
			parent: anAssoc key
			allChildren: children ].

	postBlock cull: aParent cull: anIndex cull: carry
]

{ #category : #accessing }
CTOrderPreservingTree >> roots [

	| roots alreadySeen |
	roots := self newCollection.

	alreadySeen := IdentitySet new.

	parent valuesDo: [ :anAssoc | 
		| aParent |
		aParent := anAssoc key.
		((alreadySeen includes: aParent) or: [ 
			 parent
				 at: aParent
				 ifPresent: [ :p | p key ~~ aParent ]
				 ifAbsent: [ false ] ]) ifFalse: [ 
			roots add: anAssoc.
			alreadySeen add: aParent ] ].

	^ roots collect: [ :anAssoc | anAssoc key ] as: Array
]

{ #category : #accessing }
CTOrderPreservingTree >> size [

	^ self asArray size
]

{ #category : #enumerating }
CTOrderPreservingTree >> withIndexDo: aBlock [

	self withIndexPre: aBlock withIndexPost: [ :anObj :i |  ]
]

{ #category : #enumerating }
CTOrderPreservingTree >> withIndexPre: preBlock withIndexPost: postBlock [

	| roots |
	roots := self roots.

	roots withIndexDo: [ :aRoot :i | 
		self
			pre: preBlock
			post: postBlock
			withIndex: i - roots size
			parent: aRoot
			allChildren: self childrenWithIndexes ]
]
