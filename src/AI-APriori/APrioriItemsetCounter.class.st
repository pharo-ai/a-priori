Class {
	#name : #APrioriItemsetCounter,
	#superclass : #Object,
	#instVars : [
		'transactions'
	],
	#category : #'AI-APriori'
}

{ #category : #'as yet unclassified' }
APrioriItemsetCounter class >> forTransactions: aTransactionsDatabase [
	^ self new initializeTransactions: aTransactionsDatabase
]

{ #category : #'lazy counting' }
APrioriItemsetCounter >> countOfItemset: anItemset [
	| count x |
	count := 0.
	
	transactions do: [ :transaction |
		(anItemset isSubsetOf: transaction)
			ifTrue: [ count := count + 1 ] ].
		
	^ count
]

{ #category : #initialization }
APrioriItemsetCounter >> initializeTransactions: aTransactionsDatabase [
	transactions := aTransactionsDatabase 
]
