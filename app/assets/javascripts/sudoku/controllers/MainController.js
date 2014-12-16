(function () {
	'use strict';

	angular
		.module('sudoku')
		.controller('MainController', MainController);

	MainController.$inject = ['$scope'];

	/* @ngInject */
	function MainController($scope) {
		$scope.hello = "Hello World"
	}
})();