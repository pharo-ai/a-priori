Class {
	#name : #APrioriSupportMetricTest,
	#superclass : #APrioriMetricTest,
	#instVars : [
		'metric'
	],
	#category : #'APriori-Tests'
}

{ #category : #running }
APrioriSupportMetricTest >> setUp [
	super setUp.
	metric := APrioriSupportMetric forAlgorithm: apriori.
]

{ #category : #tests }
APrioriSupportMetricTest >> testValueForAssociationRule [
	| expected actual |
	
	expected := { 1/3 . 1/3 . 1/3 . 1/3 }.
	actual := rules collect: [ :rule | metric valueForAssociationRule: rule ].
	
	self assert: actual equals: expected.
]

{ #category : #tests }
APrioriSupportMetricTest >> testValueForItemset [
	| expected actual |
	
	expected := { 1/2 . 1/3 . 1/2 . 1/3 . 1/2 . 1/3 . 1/3 }.
	actual := itemsets collect: [ :itemset | metric valueForItemset: itemset ].
	
	self assert: actual equals: expected.
]
