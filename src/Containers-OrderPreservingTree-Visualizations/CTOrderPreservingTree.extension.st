Extension { #name : #CTOrderPreservingTree }

{ #category : #'*Containers-OrderPreservingTree-Visualizations' }
CTOrderPreservingTree >> acceptSlotDescriptorsVisitor: aVisitor [

	^ aVisitor visitOrderPreservingTree: self
]

{ #category : #'*Containers-OrderPreservingTree-Visualizations' }
CTOrderPreservingTree >> asPresenter [

	^ (CTOrderPreservingTreePresenter on: self)
		  withTreePresenterDo: [ :aPresenter | 
			  aPresenter
				  addColumn: (SpStringTableColumn
						   title: 'Model'
						   evaluated: [ :aContext | aContext ]);
				  hideColumnHeaders;
				  expandAll ];
		  yourself
]

{ #category : #'*Containers-OrderPreservingTree-Visualizations' }
CTOrderPreservingTree >> asShapeValuesHorizontalTreeModelShape: modelBlock indexBlock: indexBlock [

	| dict edgeBuilder edges shapes |
	dict := IdentityDictionary new.

	shapes := OrderedCollection new.
	edges := OrderedCollection new.

	self withIndexDo: [ :each :i | 
		| valueShape indexShape compositeShape |
		valueShape := (modelBlock value: each) boxedWithPad:
			              Float goldenPlatinumRatio.

		indexShape := indexBlock cull: i cull: valueShape.

		RSLocation new
			below;
			right;
			offset: Float goldenPlatinumRatio @ indexShape height negated / 2;
			stick: indexShape on: valueShape.

		compositeShape := RSComposite new
			                  model: each;
			                  shapes: { 
					                  valueShape.
					                  indexShape };
			                  draggable;
			                  yourself.

		shapes add: compositeShape.
		dict at: each put: compositeShape ].

	edgeBuilder := RSLineBuilder orthoHorizontal
		               withHorizontalAttachPoint;
		               yourself.

	edgeBuilder shape cornerRadii: Float goldenPlatinumRatio.

	self associationsDo: [ :anAssoc | 
		| edge |
		edge := edgeBuilder
			        edgeFrom: (dict at: anAssoc key)
			        to: (dict at: anAssoc value).
		edge color: edge color translucent.
		edges add: edge ].

	RSHorizontalVanDerPloegTreeLayout on: shapes edges: edges.

	^ RSComposite new
		  shapes: shapes , edges;
		  yourself
]

{ #category : #'*Containers-OrderPreservingTree-Visualizations' }
CTOrderPreservingTree >> asShapeValuesHorizontalTreeWithLabelShapes [

	^ self
		  asShapeValuesHorizontalTreeModelShape: [ :each | 
			  RSLabel new
				  model: each;
				  fontName: 'Source Code Pro';
				  yourself ]
		  indexBlock: [ :i :modelShape | 
			  RSLabel new
				  model: i;
				  text: '(' , i asString , ')';
				  fontSizeSilverRatio;
				  yourself ]
]

{ #category : #'*Containers-OrderPreservingTree-Visualizations' }
CTOrderPreservingTree >> asShapeValuesHorizontalTreeWithOutlinerShapes [

	^ self
		  asShapeValuesHorizontalTreeModelShape: [ :each | 
		  each asShapeSlotsDfsTree: each slotDescriptorsContext ]
		  indexBlock: [ :i | 
			  RSLabel new
				  model: i;
				  text: '(' , i asString , ')';
				  fontSizeSilverRatio;
				  yourself ]
]

{ #category : #'*Containers-OrderPreservingTree-Visualizations' }
CTOrderPreservingTree >> asTreePresenter [

	| children |
	children := self children.

	^ SpTreePresenter new
		  activateOnSingleClick;
		  roots: self roots;
		  children: [ :each | children at: each ];
		  beResizable;
		  expandAll;
		  yourself
]

{ #category : #'*Containers-OrderPreservingTree-Visualizations' }
CTOrderPreservingTree >> asTreeTablePresenter [

	^ (CTOrderPreservingTreePresenter on: self)
		  withTreePresenterDo: [ :aPresenter | 
			  aPresenter addColumn: (SpStringTableColumn
						   title: 'Model'
						   evaluated: [ :aContext | aContext ]) ];
		  yourself
]

{ #category : #'*Containers-OrderPreservingTree-Visualizations' }
CTOrderPreservingTree >> inspectorCanvasValuesTree [

	<inspectorPresentationOrder: 1010 title: 'Values tree'>
	^ RSCanvas new
		  add: self asShapeValuesHorizontalTreeWithLabelShapes;
		  in: [ :aCanvas | 
			  RSSVGCairoExporter new
				  canvas: aCanvas;
				  zoomToShapesWithPadding: Float goldenPlatinumRatio;
				  export ];
		  addInteraction: RSCanvasController new;
		  inspectorCanvas
]

{ #category : #'*Containers-OrderPreservingTree-Visualizations' }
CTOrderPreservingTree >> inspectorCanvasValuesTreeContext: aContext [

	aContext withoutEvaluator
]
