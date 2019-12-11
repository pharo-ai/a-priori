Class {
	#name : #APrioriLiftMetric,
	#superclass : #APrioriMetric,
	#category : #APriori
}

{ #category : #evaluating }
APrioriLiftMetric >> valueForAssociationRule: anAssociationRule [
	| parentCount keyCount valueCount |
	
	parentCount := anAssociationRule parentItemset count.
	keyCount := anAssociationRule keyItemset count.
	valueCount := anAssociationRule valueItemset count.
	
	^ parentCount * numberOfTransactions / (keyCount * valueCount)
]

{ #category : #evaluating }
APrioriLiftMetric >> valueForItemset: anItemset [
	self shouldNotImplement
]
