Class {
	#name : #APrioriTest,
	#superclass : #TestCase,
	#instVars : [
		'transactions'
	],
	#category : #'APriori-Tests'
}

{ #category : #running }
APrioriTest >> setUp [ 
	super setUp.
	transactions := APrioriMockTransactions new transactions.
]

{ #category : #tests }
APrioriTest >> testAssociationRulesFrom [
	| apriori expected actual |
	
	apriori := APriori
		supportThreshold: 2/6
		confidenceThreshold: 2/6.
		
	expected := { 
		#(bread) asItemset => #(butter) asItemset .
		#(butter) asItemset => #(bread) asItemset .
		#(eggs) asItemset => #(bacon) asItemset .
		#(bacon) asItemset => #(eggs) asItemset }.
		
	actual := apriori associationRulesFrom: transactions.
	
	"We don't care about the order"
	expected := expected asSet.
	actual := actual asSet.
	
	self assert: actual equals: expected.
]

{ #category : #tests }
APrioriTest >> testFrequentItemsetsIn [
	| apriori expected actual |
	
	apriori := APriori
		supportThreshold: 2/6
		confidenceThreshold: 2/6.
		
	expected := { 
		#(bread butter) asItemset .
		#(eggs bacon) asItemset }.
		
	actual := apriori frequentItemsetsIn: transactions.
	
	"We don't care about the order"
	expected := expected asSet.
	actual := actual asSet.
	
	self assert: actual equals: expected.
]
