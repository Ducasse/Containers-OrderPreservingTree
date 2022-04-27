Extension { #name : #CTSlotDescriptorsVisitor }

{ #category : #'*Containers-OrderPreservingTree-Visualizations' }
CTSlotDescriptorsVisitor >> visitOrderPreservingTree: aTree [

	^ (self visitObject: aTree) , { 
		  (self newSlotDescriptorSelector
			   selector: #asShapeValuesHorizontalTreeWithLabelShapes;
			   inline;
			   quote).
		  (self newSlotDescriptorSelector
			   selector: #asShapeValuesHorizontalTreeWithOutlinerShapes:;
			   inline;
			   quote) }
]
