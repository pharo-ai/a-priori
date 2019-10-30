Class {
	#name : #AssociationRule,
	#superclass : #Association,
	#category : #APriori
}

{ #category : #'as yet unclassified' }
AssociationRule >> confidenceIn: transactions [ 
	| supportOfBoth supportOfKey |
	supportOfBoth := (self key union: self value) supportIn: transactions.
	supportOfKey := self key supportIn: transactions.
	^ supportOfBoth / supportOfKey 
]

{ #category : #printing }
AssociationRule >> printOn: aStream [
	self key printOn: aStream.
	aStream nextPutAll: ' => '.
	self value printOn: aStream.
]
