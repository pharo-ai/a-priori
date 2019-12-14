Class {
	#name : #APrioriBrowser,
	#superclass : #SpPresenter,
	#instVars : [
		'apriori',
		'table'
	],
	#category : #APriori
}

{ #category : #specs }
APrioriBrowser class >> defaultSpec [
	^ SpBoxLayout newVertical
		add: #table;
		yourself
]

{ #category : #'instance creation' }
APrioriBrowser class >> for: anAPrioriInstance [
	^ self new initializeAPriori: anAPrioriInstance
]

{ #category : #initialization }
APrioriBrowser >> initialize [
	"Do nothing"
]

{ #category : #initialization }
APrioriBrowser >> initializeAPriori: anAPrioriInstance [
	apriori := anAPrioriInstance.
	super initialize.
]

{ #category : #initialization }
APrioriBrowser >> initializePresenters [
	table := self newTable.

	table
		addColumn: (SpStringTableColumn title: 'Itemset' evaluated: #asString).
	
	apriori itemsetMetrics do: [ :metric |
		table addColumn: (SpStringTableColumn
			title: metric name evaluated: [ :itemset |
				itemset metrics at: metric class ]) ].
		
	table
		items: apriori frequentItemsets;
		beResizable
]

{ #category : #TOREMOVE }
APrioriBrowser >> title [
	^ 'A-Priori Browser'
]
