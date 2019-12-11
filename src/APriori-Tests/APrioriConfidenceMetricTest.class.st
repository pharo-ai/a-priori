Class {
	#name : #APrioriConfidenceMetricTest,
	#superclass : #APrioriMetricTest,
	#instVars : [
		'metric'
	],
	#category : #'APriori-Tests'
}

{ #category : #running }
APrioriConfidenceMetricTest >> setUp [ 
	super setUp.
	metric := APrioriConfidenceMetric new.
]

{ #category : #tests }
APrioriConfidenceMetricTest >> testValueForAssociationRule [
	| expected actual |
	
	expected := { 2/3 . 1 . 2/3 . 2/3 }.
	actual := rules collect: [ :rule | metric valueForAssociationRule: rule ].
	
	self assert: actual equals: expected.
]

{ #category : #tests }
APrioriConfidenceMetricTest >> testValueForItemset [
	self should: [ metric valueForItemset: itemsets anyOne ] raise: ShouldNotImplement.
]
