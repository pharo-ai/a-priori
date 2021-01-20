Class {
	#name : #APrioriItemsetTest,
	#superclass : #TestCase,
	#category : #'APriori-Tests'
}

{ #category : #tests }
APrioriItemsetTest >> testAsItemset [
	| itemset |
	itemset := #(a c b) asItemset.
	
	self assert: itemset class equals: APrioriItemset.
	self assert: itemset size equals: 3.
	self assert: itemset first equals: #a.
	self assert: itemset second equals: #c.
	self assert: itemset third equals: #b.
]

{ #category : #tests }
APrioriItemsetTest >> testCount [
	| itemset |
	itemset := #(a c b) asItemset.
	itemset count: 42.
	
	self assert: itemset count equals: 42.
]

{ #category : #tests }
APrioriItemsetTest >> testCountMetricsValues [
	| itemset expected |
	itemset := #(a c b) asItemset.
	itemset count: 42.
	
	expected := { APrioriCountMetric -> 42 } asDictionary.
	
	self assert: itemset metricsValues equals: expected.
]

{ #category : #tests }
APrioriItemsetTest >> testCountUnknown [
	| itemset |
	itemset := #(a c b) asItemset.
	
	self should: [ itemset count ] raise: KeyNotFound.
]

{ #category : #tests }
APrioriItemsetTest >> testEqualityDifferentElementsSameMetrics [
	| itemset1 itemset2 |
	
	itemset1 := #(a c b) asItemset.
	itemset1 metricsValues at: APrioriCountMetric put: 10.
	itemset1 metricsValues at: APrioriSupportMetric put: 0.5.
	
	itemset2 := #(w x y z) asItemset.
	itemset2 metricsValues at: APrioriCountMetric put: 10.
	itemset2 metricsValues at: APrioriSupportMetric put: 0.5.
	
	self deny: itemset1 equals: itemset2.
]

{ #category : #tests }
APrioriItemsetTest >> testEqualitySameElementsDifferentMetrics [
	| itemset1 itemset2 |
	
	itemset1 := #(a c b) asItemset.
	itemset1 metricsValues at: APrioriCountMetric put: 10.
	itemset1 metricsValues at: APrioriSupportMetric put: 0.5.
	
	itemset2 := #(a c b) asItemset.
	itemset2 metricsValues at: APrioriCountMetric put: 42.
	itemset2 metricsValues at: APrioriSupportMetric put: 0.3.
	
	self assert: itemset1 equals: itemset2.
]

{ #category : #tests }
APrioriItemsetTest >> testEqualitySameElementsDifferentOrderSameMetrics [
	| itemset1 itemset2 |
	
	itemset1 := #(a c b) asItemset.
	itemset1 metricsValues at: APrioriCountMetric put: 10.
	itemset1 metricsValues at: APrioriSupportMetric put: 0.5.
	
	itemset2 := #(a b c) asItemset.
	itemset2 metricsValues at: APrioriCountMetric put: 10.
	itemset2 metricsValues at: APrioriSupportMetric put: 0.5.
	
	self deny: itemset1 equals: itemset2.
]

{ #category : #tests }
APrioriItemsetTest >> testEqualitySameElementsSameMetrics [
	| itemset1 itemset2 |
	
	itemset1 := #(a c b) asItemset.
	itemset1 metricsValues at: APrioriCountMetric put: 10.
	itemset1 metricsValues at: APrioriSupportMetric put: 0.5.
	
	itemset2 := #(a c b) asItemset.
	itemset2 metricsValues at: APrioriCountMetric put: 10.
	itemset2 metricsValues at: APrioriSupportMetric put: 0.5.
	
	self assert: itemset1 equals: itemset2.
]

{ #category : #tests }
APrioriItemsetTest >> testPrintOn [
	| itemset stream expected actual |
	itemset := #(eggs milk butter) asItemset.
	
	stream := String new writeStream.
	itemset printOn: stream.
	
	expected := '{eggs, milk, butter}'.
	actual := stream contents.
	
	self assert: actual equals: expected.
	
	itemset count: 3.
	stream := String new writeStream.
	itemset printOn: stream.
	expected :=  '{eggs, milk, butter} [3]'.
	actual := stream contents.
	self assert: actual equals: expected.
]

{ #category : #tests }
APrioriItemsetTest >> testSameEqualitySameElementsDifferentMetrics [
	| itemset1 itemset2 |
	
	itemset1 := #(a c b) asItemset.
	itemset1 metricsValues at: APrioriCountMetric put: 10.
	itemset1 metricsValues at: APrioriSupportMetric put: 0.5.
	
	itemset2 := #(a c b) asItemset.
	itemset2 metricsValues at: APrioriCountMetric put: 42.
	itemset2 metricsValues at: APrioriSupportMetric put: 0.3.
	
	self deny: (itemset1 =!= itemset2).
]

{ #category : #tests }
APrioriItemsetTest >> testStrongEqualityDifferentElementsSameMetrics [
	| itemset1 itemset2 |
	
	itemset1 := #(a c b) asItemset.
	itemset1 metricsValues at: APrioriCountMetric put: 10.
	itemset1 metricsValues at: APrioriSupportMetric put: 0.5.
	
	itemset2 := #(w x y z) asItemset.
	itemset2 metricsValues at: APrioriCountMetric put: 10.
	itemset2 metricsValues at: APrioriSupportMetric put: 0.5.
	
	self deny: (itemset1 =!= itemset2).
]

{ #category : #tests }
APrioriItemsetTest >> testStrongEqualitySameElementsDifferentOrderSameMetrics [
	| itemset1 itemset2 |
	
	itemset1 := #(a c b) asItemset.
	itemset1 metricsValues at: APrioriCountMetric put: 10.
	itemset1 metricsValues at: APrioriSupportMetric put: 0.5.
	
	itemset2 := #(a b c) asItemset.
	itemset2 metricsValues at: APrioriCountMetric put: 10.
	itemset2 metricsValues at: APrioriSupportMetric put: 0.5.
	
	self deny: (itemset1 =!= itemset2).
]

{ #category : #tests }
APrioriItemsetTest >> testStrongEqualitySameElementsSameMetrics [
	| itemset1 itemset2 |
	
	itemset1 := #(a c b) asItemset.
	itemset1 metricsValues at: APrioriCountMetric put: 10.
	itemset1 metricsValues at: APrioriSupportMetric put: 0.5.
	
	itemset2 := #(a c b) asItemset.
	itemset2 metricsValues at: APrioriCountMetric put: 10.
	itemset2 metricsValues at: APrioriSupportMetric put: 0.5.
	
	self assert: (itemset1 =!= itemset2).
]
