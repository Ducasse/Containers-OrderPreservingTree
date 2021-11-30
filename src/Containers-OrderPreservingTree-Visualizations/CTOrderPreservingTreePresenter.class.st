Class {
	#name : #CTOrderPreservingTreePresenter,
	#superclass : #SpPresenter,
	#instVars : [
		'tree',
		'treePresenter'
	],
	#category : #'Containers-OrderPreservingTree-Visualizations'
}

{ #category : #initialization }
CTOrderPreservingTreePresenter >> initializePresenters [

	| children |
	children := tree children.

	treePresenter := self newTreeTable
		                 activateOnSingleClick;
		                 roots: tree roots;
		                 children: [ :each | children at: each ];
		                 beResizable;
		                 yourself.


	self layout: (SpBoxLayout newTopToBottom
			 add: treePresenter expand: true;
			 yourself)
]

{ #category : #initialization }
CTOrderPreservingTreePresenter >> setModelBeforeInitialization: aDomainObject [

	tree := aDomainObject
]

{ #category : #accessing }
CTOrderPreservingTreePresenter >> title [

	^ tree className , ' (' , tree size asString , ' elements)'
]

{ #category : #'as yet unclassified' }
CTOrderPreservingTreePresenter >> treeShown [

	| treeShown |
	treeShown := tree class new.

	treePresenter allShownItems do: [ :each | 
		| aParent witness |
		witness := Object new.

		aParent := tree parent: each ifAbsent: [ witness ].

		aParent == witness ifFalse: [ treeShown parent: aParent child: each ] ].

	^ treeShown
]

{ #category : #initialization }
CTOrderPreservingTreePresenter >> withTreePresenterDo: aBlock [

	^ aBlock value: treePresenter
]
