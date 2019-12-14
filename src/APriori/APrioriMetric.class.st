Class {
	#name : #APrioriMetric,
	#superclass : #Object,
	#instVars : [
		'numberOfTransactions'
	],
	#category : #APriori
}

{ #category : #accessing }
APrioriMetric >> name [
	| className |
	className := self class name.
	^ className copyFrom: ('APriori' size + 1) to: (className size - 'Metric' size).
]

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
