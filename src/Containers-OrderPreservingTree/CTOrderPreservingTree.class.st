Class {
	#name : #CTOrderPreservingTree,
	#superclass : #Object,
	#instVars : [
		'parent'
	],
	#category : #'Containers-OrderPreservingTree'
}

{ #category : #enumerating }
CTOrderPreservingTree >> allSatisfy: aBlock [

	^ self asArray allSatisfy: aBlock
]

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
		children := child at: anAssoc key ifAbsentPut: [ 
			            SortedCollection sortUsing: [ :assoc :anotherAssoc | 
				            assoc value < anotherAssoc value ] ].

		children add: aChild -> anAssoc value.

		child at: aChild ifAbsentPut: [ 
			SortedCollection sortUsing: [ :assoc :anotherAssoc | 
				assoc value < anotherAssoc value ] ] ].

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

	self roots do: [ :aRoot | 
		self do: aBlock parent: aRoot allChildren: self children ]
]

{ #category : #enumerating }
CTOrderPreservingTree >> do: aBlock parent: aParent allChildren: children [

	aBlock value: aParent.

	(children at: aParent) do: [ :aChild | 
		self do: aBlock parent: aChild allChildren: children ]
]

{ #category : #enumerating }
CTOrderPreservingTree >> do: aBlock withIndex: anIndex parent: aParent allChildren: children [

	aBlock value: aParent value: anIndex.

	(children at: aParent) do: [ :anAssoc | 
		self
			do: aBlock
			withIndex: anAssoc value
			parent: anAssoc key
			allChildren: children ]
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
CTOrderPreservingTree >> parent [

	| allParents |
	allParents := IdentityDictionary new.

	parent keysAndValuesDo: [ :aChild :anAssoc | 
		allParents at: aChild put: anAssoc key ].

	^ allParents
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
CTOrderPreservingTree >> roots [

	| roots alreadySeen |
	roots := SortedCollection sortUsing: [ :anAssoc :anotherAssoc | 
		         anAssoc value < anotherAssoc value ].

	alreadySeen := IdentitySet new.

	parent valuesDo: [ :anAssoc | 
		| aParent |
		aParent := anAssoc key.
		((parent includesKey: aParent) or: [ alreadySeen includes: aParent ]) 
			ifFalse: [ 
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

	| roots |
	roots := self roots.

	roots doWithIndex: [ :aRoot :i | 
		self
			do: aBlock
			withIndex: i - roots size
			parent: aRoot
			allChildren: self childrenWithIndexes ]
]
