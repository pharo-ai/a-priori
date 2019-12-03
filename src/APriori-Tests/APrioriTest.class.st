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
		
	rule1 := (itemsetBacon => itemsetEggs)
		count: 2;
		support: 1/3;
		confidence: 1;
		lift: 2;
		yourself.
		
	rule2 := (itemsetEggs => itemsetBacon)
		count: 2;
		support: 1/3;
		confidence: 2/3;
		lift: 2;
		yourself.
		
	rule3 := (itemsetBread => itemsetButter)
		count: 2;
		support: 1/3;
		confidence: 2/3;
		lift: 4/3;
		yourself.
		
	rule4 := (itemsetButter => itemsetBread)
		count: 2;
		support: 1/3;
		confidence: 2/3;
		lift: 4/3;
		yourself.
		
	expected := AssociationRulesCollection withAll: { rule1 . rule2 . rule3 . rule4 }.
	actual := apriori associationRules.
	
	self assert: actual equals: expected.
]

{ #category : #tests }
APrioriTest >> testCalculateConfidenceOfRule [
	| rule expected actual |
	
	rule := #(bread) asItemset => #(butter) asItemset.
	rule := apriori encoder encodeRule: rule.
	
	apriori calculateStatisticsOfRule: rule.
	
	expected := 2/3.
	actual := rule confidence.
	
	self assert: actual equals: expected.
]

{ #category : #tests }
APrioriTest >> testCalculateCountOfItemset [
	| itemset expected actual |
	
	itemset := #(bread butter) asItemset.
	itemset := apriori encoder encodeItemset: itemset.
	
	apriori calculateStatisticsOfItemset: itemset.
	
	expected := 2.
	actual := itemset count.
	
	self assert: actual equals: expected.
]

{ #category : #tests }
APrioriTest >> testCalculateCountOfRule [
	| rule expected actual |
	
	rule := #(bread) asItemset => #(butter) asItemset.
	rule := apriori encoder encodeRule: rule.
	
	apriori calculateStatisticsOfRule: rule.
	
	expected := 2.
	actual := rule count.
	
	self assert: actual equals: expected.
]

{ #category : #tests }
APrioriTest >> testCalculateKeyCountOfRule [
	| rule expected actual |
	
	rule := #(bread) asItemset => #(butter) asItemset.
	rule := apriori encoder encodeRule: rule.
	
	apriori calculateStatisticsOfRule: rule.
	
	expected := 3.
	actual := rule key count.
	
	self assert: actual equals: expected.
]

{ #category : #tests }
APrioriTest >> testCalculateKeySupportOfRule [
	| rule expected actual |
	
	rule := #(bread) asItemset => #(butter) asItemset.
	rule := apriori encoder encodeRule: rule.
	
	apriori calculateStatisticsOfRule: rule.
	
	expected := 1/2.
	actual := rule key support.
	
	self assert: actual equals: expected.
]

{ #category : #tests }
APrioriTest >> testCalculateLiftOfRule [
	| rule expected actual |
	
	rule := #(bread) asItemset => #(butter) asItemset.
	rule := apriori encoder encodeRule: rule.
	
	apriori calculateStatisticsOfRule: rule.
	
	expected := 4/3.
	actual := rule lift.
	
	self assert: actual equals: expected.
]

{ #category : #tests }
APrioriTest >> testCalculateSupportOfItemset [
	| itemset expected actual |
	
	itemset := #(bread butter) asItemset.
	itemset := apriori encoder encodeItemset: itemset.
	
	apriori calculateStatisticsOfItemset: itemset.
	
	expected := 1/3.
	actual := itemset support.
	
	self assert: actual equals: expected.
]

{ #category : #tests }
APrioriTest >> testCalculateSupportOfRule [
	| rule expected actual |
	
	rule := #(bread) asItemset => #(butter) asItemset.
	rule := apriori encoder encodeRule: rule.
	
	apriori calculateStatisticsOfRule: rule.
	
	expected := 1/3.
	actual := rule support.
	
	self assert: actual equals: expected.
]

{ #category : #tests }
APrioriTest >> testCalculateValueCountOfRule [
	| rule expected actual |
	
	rule := #(bread) asItemset => #(butter) asItemset.
	rule := apriori encoder encodeRule: rule.
	
	apriori calculateStatisticsOfRule: rule.
	
	expected := 3.
	actual := rule value count.
	
	self assert: actual equals: expected.
]

{ #category : #tests }
APrioriTest >> testCalculateValueSupportOfRule [
	| rule expected actual |
	
	rule := #(bread) asItemset => #(butter) asItemset.
	rule := apriori encoder encodeRule: rule.
	
	apriori calculateStatisticsOfRule: rule.
	
	expected := 1/2.
	actual := rule value support.
	
	self assert: actual equals: expected.
]

{ #category : #tests }
APrioriTest >> testFrequentItemsets [
	| expected actual |
	
	expected := ItemsetsCollection withAll: {
		#(eggs) asItemset
			count: 3;
			support: 1/2;
			yourself .
		
		#(butter) asItemset
			count: 3;
			support: 1/2;
			yourself .
			
		#(bread) asItemset
			count: 3;
			support: 1/2;
			yourself .
			
		#(bacon) asItemset
			count: 2;
			support: 1/3;
			yourself .
			
		#(milk) asItemset
			count: 2;
			support: 1/3;
			yourself .
			
		#(eggs bacon) asItemset
			count: 2;
			support: 1/3;
			yourself .
			
		#(butter bread) asItemset
			count: 2;
			support: 1/3;
			yourself .
	}.
		
	actual := apriori frequentItemsets.
	
	self assert: actual equals: expected.
]
