app = angular.module 'deckWorkout', []

app.directive 'backImg', ->
  ($scope, element, attrs) ->
    element.css 'background-image': 'url(' + attrs.backImg + ')'

app.controller 'CardController', ($scope) ->

  suiteIndex = (suite) ->
    ['Clubs', 'Diamonds', 'Hearts', 'Spades'].indexOf(suite)

  imagePath = (suite, value) ->
    path = 'img/' + suite + '/' + value
    switch suite
      when 'Clubs'
        path += 'C'
      when 'Diamonds'
        path += 'D'
      when 'Hearts'
        path += 'H'
      when 'Spades'
        path += 'S'
    path += '.svg'
    path

  $scope.newCard = (suite, value) ->
    { suite: suite, value: value, image: imagePath(suite, value), workout: 'Burpees' }

  $scope.cards = _.flatten _.map ['Clubs', 'Diamonds', 'Hearts', 'Spades'], (suite) ->
    _.map ['2', '3', '4', '5', '6', '7', '8', '9', '10', 'J', 'Q', 'K', 'A'], (value) ->
      $scope.newCard(suite, value)

  $scope.workouts = ['Push Ups', 'Sit Ups', 'Squats', 'Burpees', 'Jumping Jacks', 'Chair Dips', 'Mountain Climbers', 'Lunges']

  $scope.shuffleCards = ->
    $scope.shuffle($scope.cards)

  $scope.shuffleWorkouts = ->
    $scope.shuffle($scope.workouts)

  $scope.shuffle = (cards) ->
    i = cards.length
    while --i > 0
      j = ~~(Math.random() * (i + 1))
      temp = cards[j]
      cards[j] = cards[i]
      cards[i] = temp

  $scope.topCard = ->
    $scope.cards[0]

  $scope.cardsRemain = ->
    $scope.cards.length > 0
