Class {
	#name : #APrioriLiftMetricTest,
	#superclass : #APrioriMetricTest,
	#instVars : [
		'metric'
	],
	#category : #'APriori-Tests'
}

{ #category : #running }
APrioriLiftMetricTest >> setUp [ 
	super setUp.
	metric := APrioriLiftMetric new.
	metric numberOfTransactions: 6.
]

{ #category : #tests }
APrioriLiftMetricTest >> testValueForAssociationRule [
	| expected actual |
	
	expected := { 2 . 2 . 4/3 . 4/3 }.
	actual := rules collect: [ :rule | metric valueForAssociationRule: rule ].
	
	self assert: actual equals: expected.
]

{ #category : #tests }
APrioriLiftMetricTest >> testValueForItemset [
	self should: [ metric valueForItemset: itemsets anyOne ] raise: ShouldNotImplement.
]
