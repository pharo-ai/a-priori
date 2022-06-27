Class {
	#name : #APrioriMetric,
	#superclass : #Object,
	#instVars : [
		'numberOfTransactions'
	],
	#category : #'AI-APriori'
}

{ #category : #accessing }
APrioriMetric >> numberOfTransactions: aNumber [
	numberOfTransactions := aNumber
]

{ #category : #evaluating }
APrioriMetric >> valueForAssociationRule: anAssociationRule [
	self subclassResponsibility
]

{ #category : #evaluating }
APrioriMetric >> valueForItemset: anItemset [
	self subclassResponsibility
]
