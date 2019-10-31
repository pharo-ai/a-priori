Class {
	#name : #APrioriTest,
	#superclass : #TestCase,
	#instVars : [
		'transactions',
		'apriori'
	],
	#category : #'APriori-Tests'
}

{ #category : #running }
APrioriTest >> setUp [ 
	super setUp.
	transactions := APrioriMockTransactions new transactions.
	
	apriori := APriori
		transactions: transactions
		supportThreshold: 2/6
		confidenceThreshold: 2/6.
]

{ #category : #tests }
APrioriTest >> testAssociationRules [
	| itemsetBread itemsetButter itemsetBacon itemsetEggs rule1 rule2 rule3 rule4 expected actual |
	
	itemsetBread := #(bread) asItemset
		count: 3;
		support: 1/2;
		yourself.
		
	itemsetButter := #(butter) asItemset
		count: 3;
		support: 1/2;
		yourself.
		
	itemsetBacon := #(bacon) asItemset 
		count: 2;
		support: 1/3;
		yourself.
		
	itemsetEggs := #(eggs) asItemset
		count: 3;
		support: 1/2;
		yourself.
		
	rule1 := (itemsetBread => itemsetButter)
		count: 2;
		support: 1/3;
		confidence: 2/3;
		lift: 4/3;
		yourself.
		
	rule2 := (itemsetButter => itemsetBread)
		count: 2;
		support: 1/3;
		confidence: 2/3;
		lift: 4/3;
		yourself.
		
	rule3 := (itemsetBacon => itemsetEggs)
		count: 2;
		support: 1/3;
		confidence: 1;
		lift: 2;
		yourself.
		
	rule4 := (itemsetEggs => itemsetBacon)
		count: 2;
		support: 1/3;
		confidence: 2/3;
		lift: 2;
		yourself.
		
	expected := { rule1 . rule2 . rule3 . rule4 }.
	actual := apriori associationRules.
	
	"We don't care about the order"
	expected := expected asSet.
	actual := actual asSet.
	
	self assert: actual equals: expected.
]

{ #category : #tests }
APrioriTest >> testCalculateStatisticsOfItemset [
	| counts supports expected actual |
	
	counts := #(1 1 2 2 1 1).
	supports := { 1/6 . 1/6 . 1/3 . 1/3 . 1/6 . 1/6 }.
	
	expected := transactions withIndexCollect: [ :each :i |
		each asItemset
			count: (counts at: i);
			support: (supports at: i);
			yourself ].
	
	actual := transactions collect: [ :each | each asItemset ].
	actual do: [ :itemset | apriori calculateStatisticsOfItemset: itemset ].
	
	self assert: actual equals: expected.
]

{ #category : #tests }
APrioriTest >> testFrequentItemsets [
	| itemset1 itemset2 expected actual |
	
	itemset1 := #(eggs bacon) asItemset
		count: 2;
		support: 1/3;
		yourself.
	
	itemset2 := #(bread butter) asItemset
		count: 2;
		support: 1/3;
		yourself.
		
	expected := { itemset1 . itemset2 }.
	actual := apriori frequentItemsets.
	self assert: actual equals: expected.
]
