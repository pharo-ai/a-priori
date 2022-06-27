Class {
	#name : #APrioriSupportMetric,
	#superclass : #APrioriMetric,
	#category : #'AI-APriori'
}

{ #category : #evaluating }
APrioriSupportMetric >> valueForAssociationRule: anAssociationRule [
	^ self valueForItemset: anAssociationRule parentItemset
]

{ #category : #evaluating }
APrioriSupportMetric >> valueForItemset: anItemset [
	^ anItemset count / numberOfTransactions
]
