(function () {
	'use strict';

	angular
		.module('sudoku', [
			'Devise',
			'ngAnimate',
			'ngResource',
			'ui.router',
			'templates'
		])
		.config(function ($sceProvider, $stateProvider, $urlRouterProvider, $locationProvider, AuthProvider) {
			$sceProvider.enabled(false);

			$stateProvider
				.state('home', {
					templateUrl: 'home.html',
					controller: 'MainController'
				})
				.state('game', {
					templateUrl: 'game.html',
					controller: 'GameController'
				})
				.state('winner-page', {
					templateUrl: 'winner.html',
					controller: 'GameController'
				})
				.state('game-history', {
					templateUrl: 'history.html',
					controller: 'GameController'
				});


			$urlRouterProvider.otherwise('/');

			$locationProvider.html5Mode({
				enabled: true,
				requireBase: false
			});




		})
		.run(function ($rootScope, $state){
			$state.go('home');

		})
})();