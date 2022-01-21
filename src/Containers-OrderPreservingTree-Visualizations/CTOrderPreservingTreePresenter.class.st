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
CTOrderPreservingTreePresenter >> initializeWindow: aWindow [

	aWindow
		initialExtent: 1 @ Float silverRatio * 1e3;
		title: tree className , ' (' , tree size asString , ' elements)'
]

{ #category : #initialization }
CTOrderPreservingTreePresenter >> setModelBeforeInitialization: aDomainObject [

	tree := aDomainObject
]

{ #category : #initialization }
CTOrderPreservingTreePresenter >> withTreePresenterDo: aBlock [

	^ aBlock value: treePresenter
]
