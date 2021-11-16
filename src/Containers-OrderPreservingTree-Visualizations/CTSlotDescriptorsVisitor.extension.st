Extension { #name : #CTSlotDescriptorsVisitor }

{ #category : #'*Containers-OrderPreservingTree-Visualizations' }
CTSlotDescriptorsVisitor >> visitOrderPreservingTree: aTree [

	^ (self visitObject: aTree)
	  , { (#asShapeValuesHorizontalTree asSlotDescriptor
			   inline: true;
			   quote) }
]
