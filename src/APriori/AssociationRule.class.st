Class {
	#name : #AssociationRule,
	#superclass : #Association,
	#instVars : [
		'count',
		'support',
		'confidence',
		'lift'
	],
	#category : #APriori
}

{ #category : #converting }
AssociationRule >> = anObject [
	(super = anObject)
		ifFalse: [ ^ false ].
		
	^ { self count . self support . self confidence . self lift } = { anObject count . anObject support . anObject confidence . anObject lift }
]

{ #category : #converting }
AssociationRule >> asItemset [
	^ self key union: self value
]

{ #category : #accessing }
AssociationRule >> confidence [
	^ confidence
]

{ #category : #accessing }
AssociationRule >> confidence: anObject [
	confidence := anObject
]

{ #category : #accessing }
AssociationRule >> count [
	^ count
]

{ #category : #accessing }
AssociationRule >> count: anObject [
	count := anObject
]

{ #category : #accessing }
AssociationRule >> lift [
	^ lift
]

{ #category : #accessing }
AssociationRule >> lift: anObject [
	lift := anObject
]

{ #category : #printing }
AssociationRule >> printOn: aStream [
	self key printOn: aStream.
	aStream nextPutAll: ' => '.
	self value printOn: aStream.
]

{ #category : #accessing }
AssociationRule >> support [
	^ support
]

{ #category : #accessing }
AssociationRule >> support: anObject [
	support := anObject
]
