Extension { #name : #CTSlotDescriptorsVisitor }

{ #category : #'*Containers-OrderPreservingTree-Visualizations' }
CTSlotDescriptorsVisitor >> visitOrderPreservingTree: aTree [

	^ (self visitObject: aTree)
	  ,
		  { (#asShapeValuesHorizontalTreeWithOutlinerShapes asSlotDescriptor
			   inline: true;
			   quote) }
]
