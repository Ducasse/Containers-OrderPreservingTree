Class {
	#name : #BaselineOfContainersOrderPreservingTree,
	#superclass : #BaselineOf,
	#category : #BaselineOfContainersOrderPreservingTree
}

{ #category : #baselines }
BaselineOfContainersOrderPreservingTree >> baseline: spec [

	<baseline>
	spec for: #common do: [
		spec
			package: 'Containers-OrderPreservingTree';
			package: 'Containers-OrderPreservingTree-Tests';
			package: 'Containers-OrderPreservingTree-Visualizations' ]
]
