Extension { #name : #CTSlotDescriptorsVisitor }

{ #category : #'*Containers-OrderPreservingTree-Visualizations' }
CTSlotDescriptorsVisitor >> visitOrderPreservingTree: aTree [

	^ (self visitObject: aTree) , { 
		  (#asShapeValuesHorizontalTreeWithLabelShapes asSlotDescriptor
			   inline;
			   quote).
		  (#asShapeValuesHorizontalTreeWithOutlinerShapes asSlotDescriptor
			   inline;
			   quote) }
]
