Extension { #name : #CTSlotDescriptorsVisitor }

{ #category : #'*Containers-OrderPreservingTree-Visualizations' }
CTSlotDescriptorsVisitor >> visitOrderPreservingTree: aTree [

	^ (self visitObject: aTree) , { 
		  ((self newSlotDescriptorSelector:
				    #asShapeValuesHorizontalTreeWithLabelShapes)
			   inline;
			   quote).
		  ((self newSlotDescriptorSelector:
				    #asShapeValuesHorizontalTreeWithOutlinerShapes:)
			   inline;
			   quote) }
]
