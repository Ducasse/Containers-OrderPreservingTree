Class {
	#name : #BaselineOfOrderPreservingTree,
	#superclass : #BaselineOf,
	#category : #BaselineOfOrderPreservingTree
}

{ #category : #baselines }
BaselineOfOrderPreservingTree >> baseline: spec [

	<baseline>
	spec for: #common do: [
		spec
			package: 'Containers-OrderPreservingTree';
			package: 'Containers-OrderPreservingTree-Tests';
			package: 'Containers-OrderPreservingTree-Visualizations' ]
]
