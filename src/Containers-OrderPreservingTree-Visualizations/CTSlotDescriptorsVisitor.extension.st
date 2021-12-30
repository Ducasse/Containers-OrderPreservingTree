Extension { #name : #CTSlotDescriptorsVisitor }

{ #category : #'*Containers-OrderPreservingTree-Visualizations' }
CTSlotDescriptorsVisitor >> visitOrderPreservingTree: aTree [

	^ (self visitObject: aTree) , { 
		  (#asShapeValuesHorizontalTreeWithLabelShapes asSlotDescriptor
			   inline: true;
			   quote).
		  (#asShapeValuesHorizontalTreeWithOutlinerShapes asSlotDescriptor
			   inline: true;
			   quote) }
]
