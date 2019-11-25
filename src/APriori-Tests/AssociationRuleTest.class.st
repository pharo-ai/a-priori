Class {
	#name : #AssociationRuleTest,
	#superclass : #TestCase,
	#instVars : [
		'transactions'
	],
	#category : #'APriori-Tests'
}

{ #category : #running }
AssociationRuleTest >> setUp [ 
	super setUp.
	transactions := APrioriMockTransactions new transactions.
]

{ #category : #tests }
AssociationRuleTest >> testAsItemset [
	| itemset1 itemset2 rule expected actual |
	
	itemset1 := #(eggs milk butter) asItemset.
	itemset2 := #(avocado bananas) asItemset.
	rule := itemset1 => itemset2.
	
	expected := #(eggs milk butter avocado bananas) asItemset.
	actual := rule asItemset.
	
	self assert: actual equals: expected.
]

{ #category : #tests }
AssociationRuleTest >> testPrintOn [
	| itemset1 itemset2 rule stream expected actual |
	
	itemset1 := #(eggs milk butter) asItemset.
	itemset2 := #(avocado bananas) asItemset.
	rule := itemset1 => itemset2.
	
	stream := String new writeStream.
	rule printOn: stream.
	
	expected := '{eggs, milk, butter} => {avocado, bananas}'.
	actual := stream contents.
	
	self assert: actual equals: expected.
]
