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

{ #category : #accessing }
CTOrderPreservingTree >> children [

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
		children := (child at: each)
			            collect: [ :anAssoc | anAssoc key ]
			            as: Array.

		child at: each put: children ].

	^ child
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
