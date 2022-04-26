Extension { #name : #CTSlotDescriptorsVisitor }

{ #category : #'*Containers-OrderPreservingTree-Visualizations' }
CTSlotDescriptorsVisitor >> visitOrderPreservingTree: aTree [

	^ (self visitObject: aTree) , { 
		  (self newSlotDescriptor
			   selector: #asShapeValuesHorizontalTreeWithLabelShapes;
			   inline;
			   quote).
		  (self newSlotDescriptor
			   selector: #asShapeValuesHorizontalTreeWithOutlinerShapes:;
			   inline;
			   quote) }
]
