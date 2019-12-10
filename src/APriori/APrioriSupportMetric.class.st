Class {
	#name : #APrioriSupportMetric,
	#superclass : #APrioriMetric,
	#category : #APriori
}

{ #category : #evaluating }
APrioriSupportMetric >> valueForAssociationRule: anAssociationRule [
	^ self valueForItemset: anAssociationRule parentItemset
]

{ #category : #evaluating }
APrioriSupportMetric >> valueForItemset: anItemset [
	^ (algorithm countOfItemset: anItemset) /  algorithm numberOfTransactions
]
