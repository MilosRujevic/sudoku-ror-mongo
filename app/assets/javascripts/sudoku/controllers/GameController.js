(function () {
	'use strict';

	angular
		.module('sudoku')
		.controller('GameController', GameController);

	GameController.$inject = ['$scope', '$http', '$state'];

	/* @ngInject */
	function GameController($scope, $http, $state) {
		var testUrl = '/games/5490037149546d657c010000.json';

		$scope.checkSudoku = checkSudoku;

		fetchSudoku();

		function fetchSudoku(){
			$http.get(testUrl).success(function (data) {
				$scope.puzzle = data.puzzle.sudoku;
				$scope.solution = data.puzzle.solution;
			});
		}

		function checkSudoku(){
			var errorCount = 0;
			for (var i = 0; i < $scope.puzzle.length; i++) {
				if($scope.puzzle[i] !== $scope.solution[i]){
					errorCount++;
				}
			}
			if (errorCount >= 0){
				alert('You have: ' + errorCount + ' errors. ' + 'Keep playing!');
			} else {
				$state.go('winner-page');
			}

		}




	}
})();