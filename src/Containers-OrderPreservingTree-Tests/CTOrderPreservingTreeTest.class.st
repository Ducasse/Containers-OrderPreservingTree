"
A CTOrderPreservingTreeTest is a test class for testing the behavior of CTOrderPreservingTree
"
Class {
	#name : #CTOrderPreservingTreeTest,
	#superclass : #TestCase,
	#category : #'Containers-OrderPreservingTree-Tests'
}

{ #category : #tests }
CTOrderPreservingTreeTest >> testAdd [

	| tree children |
	tree := CTOrderPreservingTree new.

	tree
		parent: 3 child: 4;
		parent: 4 child: 6;
		parent: 3 child: 5.

	children := tree children.

	self
		deny: tree isEmpty;
		assert: tree size equals: 4;
		assert: tree asArray equals: #( 3 4 6 5 );
		assert: tree roots equals: #( 3 );
		assert: (children at: 3) equals: #( 4 5 );
		assert: (children at: 4) equals: #( 6 );
		assert: (children at: 5) equals: #(  );
		assert: (children at: 6) equals: #(  )
]

{ #category : #tests }
CTOrderPreservingTreeTest >> testCreation [

	self assertEmpty: CTOrderPreservingTree new
]
