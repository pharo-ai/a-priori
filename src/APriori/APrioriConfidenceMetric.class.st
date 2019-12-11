Class {
	#name : #APrioriConfidenceMetric,
	#superclass : #APrioriMetric,
	#category : #APriori
}

{ #category : #evaluating }
APrioriConfidenceMetric >> valueForAssociationRule: anAssociationRule [
	| parentCount keyCount |
	
	parentCount := anAssociationRule parentItemset count.
	keyCount := anAssociationRule keyItemset count.
	
	^ parentCount / keyCount
]

{ #category : #evaluating }
APrioriConfidenceMetric >> valueForItemset: anItemset [
	self shouldNotImplement
]
