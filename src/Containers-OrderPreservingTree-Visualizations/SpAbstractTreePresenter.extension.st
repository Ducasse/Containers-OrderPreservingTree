Extension { #name : #SpAbstractTreePresenter }

{ #category : #'*Containers-OrderPreservingTree-Visualizations' }
SpAbstractTreePresenter >> shownOrderPreservingTree: tree [

	| witness treeShown |
	treeShown := tree class new.
	witness := Object new.

	self allShownItems do: [ :each | 
		| aParent |
		aParent := tree parent: each ifAbsent: [ witness ].

		aParent == witness ifFalse: [ treeShown parent: aParent child: each ] ].

	^ treeShown
]
