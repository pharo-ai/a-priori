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
APrioriTest >> testBuildAssociationRules [
	apriori minCount: 2.
	apriori findFrequentItemsets.
	apriori buildAssociationRules.
	
	self assert: apriori associationRules equals: {
		#(bread) asItemset => #(butter) asItemset .
		#(butter) asItemset => #(bread) asItemset .
		#(bacon) asItemset => #(eggs) asItemset .
		#(eggs) asItemset => #(bacon) asItemset } asOrderedCollection.
]

{ #category : #tests }
APrioriTest >> testCalculateAssociationRuleMetrics [
	apriori findFrequentItemsets.
	apriori buildAssociationRules.
	apriori calculateAssociationRuleMetrics: { APrioriCountMetric . APrioriSupportMetric . APrioriConfidenceMetric . APrioriLiftMetric }.
	
	self assert: apriori associationRuleMetrics size equals: 4.
	self assert: apriori associationRuleMetrics first class equals: APrioriCountMetric.
	self assert: apriori associationRuleMetrics second class equals: APrioriSupportMetric.
	self assert: apriori associationRuleMetrics third class equals: APrioriConfidenceMetric.
	self assert: apriori associationRuleMetrics fourth class equals: APrioriLiftMetric.
]

{ #category : #tests }
APrioriTest >> testCalculateItemsetMetrics [
	apriori minCount: 2.
	apriori findFrequentItemsets.
	apriori calculateItemsetMetrics: { APrioriCountMetric . APrioriSupportMetric }.
	
	self assert: apriori itemsetMetrics size equals: 2.
	self assert: apriori itemsetMetrics first class equals: APrioriCountMetric.
	self assert: apriori itemsetMetrics second class equals: APrioriSupportMetric.
	
	self assert: (apriori frequentItemsets collect: [ :each | each -> each count ]) asDictionary equals: {
		#(eggs) asItemset -> 3 .
		#(milk) asItemset -> 2 .
		#(butter) asItemset -> 3 .
		#(bacon) asItemset -> 2 .
		#(bread) asItemset -> 3 .
		#(bacon eggs) asItemset -> 2 .
		#(bread butter) asItemset -> 2
	} asDictionary.
]

{ #category : #tests }
APrioriTest >> testFindFrequentItemsets [
	apriori minCount: 2.
	apriori findFrequentItemsets.

	self assertCollection: apriori frequentItemsets hasSameElements: {
		#(butter) asItemset .
		#(bacon) asItemset .
		#(eggs) asItemset .
		#(bread) asItemset .
		#(milk) asItemset .
		#(bread butter) asItemset .
		#(bacon eggs) asItemset }.
		
	self assert: (apriori frequentItemsets collect: [ :each | each count ]) equals: #(3 3 2 3 2 2 2) asOrderedCollection. 
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
APrioriTest >> testMinCount [
	self assert: apriori minCount equals: 1.
	
	apriori minCount: 42.
	self assert: apriori minCount equals: 42.
]

{ #category : #tests }
APrioriTest >> testMinSupport [
	self assert: apriori minSupport closeTo: 1 / transactions size.
	
	apriori minSupport: 0.1.
	self assert: apriori minSupport closeTo: 0.1.
]

{ #category : #tests }
APrioriTest >> testNumberOfTransactions [
	self assert: apriori numberOfTransactions equals: transactions size.
]
