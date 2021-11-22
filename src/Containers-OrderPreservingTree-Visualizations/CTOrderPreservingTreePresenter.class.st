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
	"			 spacing: 5;"
]

{ #category : #initialization }
CTOrderPreservingTreePresenter >> setModelBeforeInitialization: aDomainObject [

	tree := aDomainObject
]

{ #category : #accessing }
CTOrderPreservingTreePresenter >> title [

	^ tree className , ' (' , tree size asString , ' elements)'
]

{ #category : #initialization }
CTOrderPreservingTreePresenter >> withTreePresenterDo: aBlock [

	^ aBlock value: treePresenter
]
