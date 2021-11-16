Extension { #name : #CTOrderPreservingTree }

{ #category : #'*Containers-OrderPreservingTree-Visualizations' }
CTOrderPreservingTree >> acceptSlotDescriptorsVisitor: aVisitor [

	^ aVisitor visitOrderPreservingTree: self
]

{ #category : #'*Containers-OrderPreservingTree-Visualizations' }
CTOrderPreservingTree >> asShapeValuesHorizontalTree [

	| dict edgeBuilder edges shapes |
	dict := IdentityDictionary new.

	shapes := OrderedCollection new.
	edges := OrderedCollection new.

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
			offset:
				valueShape width + indexShape width / 2 * Float goldenRatio @ 0;
			move: indexShape on: valueShape.

		compositeShape := RSComposite new
			                  model: each;
			                  addShape: valueShape;
			                  addShape: indexShape;
			                  padding: Float platinumRatio;
			                  draggable;
			                  yourself.

		shapes add: compositeShape.
		dict at: each put: compositeShape ].

	edgeBuilder := RSEdgeBuilder horizontalBezier
		               withHorizontalAttachPoint;
		               yourself.

	self associationsDo: [ :anAssoc | 
		| edge |
		edge := edgeBuilder
			        edgeFrom: (dict at: anAssoc key)
			        to: (dict at: anAssoc value).
		edges add: edge ].

	RSHorizontalGaussianJitterVanDerPloegTreeLayout
		on: shapes
		edges: edges.

	^ RSComposite new
		  shapes: shapes , edges;
		  yourself
]

{ #category : #'*Containers-OrderPreservingTree-Visualizations' }
CTOrderPreservingTree >> asTreePresenter [

	^ CTOrderPreservingTreePresenter on: self
]

{ #category : #'*Containers-OrderPreservingTree-Visualizations' }
CTOrderPreservingTree >> inspectorCanvasValuesTree [

	<inspectorPresentationOrder: 1010 title: 'Values tree'>
	^ RSCanvas new
		  add: self asShapeValuesHorizontalTree;
		  addInteraction: RSCanvasController new;
		  inspectorCanvas
]

{ #category : #'*Containers-OrderPreservingTree-Visualizations' }
CTOrderPreservingTree >> inspectorCanvasValuesTreeContext: aContext [

	aContext withoutEvaluator
]
