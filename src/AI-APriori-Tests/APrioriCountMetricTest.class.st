Class {
	#name : #APrioriCountMetricTest,
	#superclass : #APrioriMetricTest,
	#instVars : [
		'metric'
	],
	#category : #'AI-APriori-Tests'
}

{ #category : #running }
APrioriCountMetricTest >> setUp [
	super setUp.
	metric := APrioriCountMetric new.
]

{ #category : #tests }
APrioriCountMetricTest >> testValueForAssociationRule [
	| expected actual |
	
	expected := #(2 2 2 2).
	actual := rules collect: [ :rule | metric valueForAssociationRule: rule ].
	
	self assert: actual equals: expected.
]

{ #category : #tests }
APrioriCountMetricTest >> testValueForItemset [
	| expected actual |
	
	expected := #(3 2 3 2 3 2 2).
	actual := itemsets collect: [ :itemset | metric valueForItemset: itemset ].
	
	self assert: actual equals: expected.
]
