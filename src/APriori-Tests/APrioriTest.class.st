Class {
	#name : #APrioriTest,
	#superclass : #TestCase,
	#instVars : [
		'transactions',
		'transactionsSource',
		'apriori'
	],
	#category : #'APriori-Tests'
}

{ #category : #running }
APrioriTest >> setUp [
	super setUp.
	
	transactions := #(
		(eggs milk butter)
		(milk cereal)
		(eggs bacon)
		(bread butter)
		(bread bacon eggs)
		(bread avocado butter bananas)).
  
	transactionsSource := APrioriTransactionsArray from: transactions.
	apriori := APriori forTransactions: transactionsSource.
]

{ #category : #tests }
APrioriTest >> testAssociationRules [
	self assert: apriori associationRules equals: OrderedCollection new.
]

{ #category : #tests }
APrioriTest >> testCalculateAssociationRuleMetrics [
	apriori calculateAssociationRuleMetrics: { APrioriConfidenceMetric . APrioriLiftMetric }.
	
	self assert: apriori associationRuleMetrics size equals: 2.
	self assert: apriori associationRuleMetrics first class equals: APrioriConfidenceMetric.
	self assert: apriori associationRuleMetrics second class equals: APrioriLiftMetric.
]

{ #category : #tests }
APrioriTest >> testCalculateItemsetMetrics [
	apriori calculateItemsetMetrics: { APrioriCountMetric . APrioriSupportMetric }.
	
	self assert: apriori itemsetMetrics size equals: 2.
	self assert: apriori itemsetMetrics first class equals: APrioriCountMetric.
	self assert: apriori itemsetMetrics second class equals: APrioriSupportMetric.
]

{ #category : #tests }
APrioriTest >> testFrequentItemsets [
	self assert: apriori frequentItemsets equals: OrderedCollection new.
]

{ #category : #tests }
APrioriTest >> testInstanceCreation [
	self assert: apriori class equals: APriori.
]

{ #category : #tests }
APrioriTest >> testItemsetMetricsEmpty [
	self assert: apriori itemsetMetrics equals: OrderedCollection new.
]

{ #category : #tests }
APrioriTest >> testNumberOfTransactions [
	self assert: apriori numberOfTransactions equals: 6.
]
