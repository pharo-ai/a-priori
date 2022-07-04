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
			package: 'AI-APriori' with: [ spec requires: #('ContainersOrderedSet') ];
			package: 'AI-APriori-Tests' with: [ spec requires: #('AI-APriori') ] ]
]
