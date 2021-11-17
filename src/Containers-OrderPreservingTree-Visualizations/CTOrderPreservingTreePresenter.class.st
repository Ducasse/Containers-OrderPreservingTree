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

	treePresenter := self newTree
		                 activateOnSingleClick;
		                 roots: tree roots;
		                 children: [ :each | children at: each ];
		                 displayIcon: [ :each | each systemIcon ];
		                 yourself.


	self layout: (SpBoxLayout newTopToBottom
			 spacing: 5;
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

{ #category : #accessing }
CTOrderPreservingTreePresenter >> treePresenter [

	^ treePresenter
]
