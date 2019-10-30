Class {
	#name : #BaselineOfAPriori,
	#superclass : #BaselineOf,
	#category : #BaselineOfAPriori
}

{ #category : #baselines }
BaselineOfAPriori >> baseline: spec [
	<baseline>
	spec for: #common do: [	
				
		"Packages"
		spec 
			package: 'APriori';
			package: 'APriori-Tests' with: [ spec requires: #('APriori') ] ]
]
