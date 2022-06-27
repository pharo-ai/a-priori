Class {
	#name : #BaselineOfAIAPriori,
	#superclass : #BaselineOf,
	#category : #BaselineOfAIAPriori
}

{ #category : #baselines }
BaselineOfAIAPriori >> baseline: spec [
	<baseline>
	spec for: #common do: [	
		"External dependencies"
		spec
			baseline: 'ContainersOrderedSet'
			with: [ spec repository: 'github://olekscode/Containers-OrderedSet/src' ].
				
		"Packages"
		spec 
			package: 'APriori' with: [ spec requires: #('ContainersOrderedSet') ];
			package: 'APriori-Tests' with: [ spec requires: #('APriori') ] ]
]
