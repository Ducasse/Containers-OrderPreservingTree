Extension { #name : #CTOrderPreservingTree }

{ #category : #'*Containers-OrderPreservingTree-Visualizations' }
CTOrderPreservingTree >> acceptSlotDescriptorsVisitor: aVisitor [

	^ aVisitor visitOrderPreservingTree: self
]

{ #category : #'*Containers-OrderPreservingTree-Visualizations' }
CTOrderPreservingTree >> asShapeValuesHorizontalTree [

	| dict edgeBuilder edges shapes |
	dict := IdentityDictionary new.

	self withIndexDo: [ :each :i | 
		| valueShape indexShape compositeShape |
		valueShape := RSLabel new
			              model: each;
			              fontName: 'Source Code Pro';
			              yourself.

		indexShape := RSLabel new
			              model: i;
			              text: '(' , i asString , ')';
			              fontSize: valueShape fontSize * Float silverRatio;
			              yourself.

		RSLocation new bottom right
			offset: indexShape textWidth + Float goldenRatio @ 0;
			move: indexShape on: valueShape.

		compositeShape := RSComposite new
			                  model: each;
			                  addShape: valueShape;
			                  addShape: indexShape;
			                  adjustToChildren;
			                  padding: Float platinumRatio;
			                  draggable;
			                  yourself.

		dict at: each put: compositeShape ].

	shapes := dict values.

	edgeBuilder := RSEdgeBuilder horizontalBezier
		               withHorizontalAttachPoint;
		               yourself.

	edges := OrderedCollection new.

	self children in: [ :children | 
		self do: [ :each | 
			parent at: each ifPresent: [ :anAssoc | 
				| edge |
				edge := edgeBuilder
					        edgeFrom: (dict at: anAssoc key)
					        to: (dict at: each).
				edges add: edge ] ] ].

	RSHorizontalGaussianJitterVanDerPloegTreeLayout
		on: shapes
		edges: edges.

	^ RSComposite new
		  shapes: shapes , edges;
		  yourself
]
