(function() {

  var w;

  try {
    w = angular.module('aquarium'); 
  } catch (e) {
    w = angular.module('aquarium', ['ngCookies','ui.ace']); 
  } 

  w.controller('sequenceCtrl', [ '$scope', '$http', '$attrs', '$location', function ($scope,$http,$attrs,$location) {

    var id = window.location.pathname.split('/')[2];
    $scope.width = 128;

    $http.get("/sequences/" + id + ".json").then(function(response) {

      $scope.sequence = response.data;
      $scope.sequence.latest = $scope.sequence.sequence_versions[$scope.sequence.sequence_versions.length-1];
      blockulate();

    });

    function blockulate() {
      $scope.sequence.blocks = [];
      for ( var i=0; i<$scope.sequence.latest.data.length; i += $scope.width) {
        $scope.sequence.blocks.push($scope.sequence.latest.data.slice(i,i+$scope.width));
      }      
    }

    $scope.change = function(block,i) {

      var position = $("#input_"+i).caret();
      var s = "";

      $scope.sequence.blocks[i] = block;
      aq.each($scope.sequence.blocks,function(b) { s += b; });
      $scope.sequence.latest.data = s;
      blockulate();

      $scope.$watch("sequence.blocks", function (value) {
        $scope.$evalAsync(function() {
          if ( position >= $scope.width ) {
            $("#input_"+i).caret(position);
            $("#input_"+(i+1)).focus().caret(position % $scope.width);
          } else if ( position == 0 && i > 0 ) {
            $("#input_"+(i-1)).focus().caret($scope.width);
          } else {
            $("#input_"+i).caret(position);
          }
        });
      });

    }


  }])

})();