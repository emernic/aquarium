(function() {

  var w;

  try {
    w = angular.module('aquarium'); 
  } catch (e) {
    w = angular.module('aquarium', ['ngCookies','ui.ace']); 
  } 

  w.controller('sequenceCtrl', [ '$scope', '$http', '$attrs', '$location', function ($scope,$http,$attrs,$location) {

    var id = window.location.pathname.split('/')[2];
    $scope.width = 100;

    function setup(data) {

      $scope.sequence = data;
      var n = $scope.sequence.sequence_versions.length;
      if ( n > 0 ) {
        $scope.sequence.latest = $scope.sequence.sequence_versions[n-1];
      } else {
        $scope.sequence.latest = { data: "" };
      }
      blockulate();

    }

    $http.get("/sequences/" + id + ".json").then(function(response) {
      setup(response.data);
    });

    function blockulate() {
      $scope.sequence.blocks = [];
      for ( var i=0; i<$scope.sequence.latest.data.length; i += $scope.width) {
        $scope.sequence.blocks.push($scope.sequence.latest.data.slice(i,i+$scope.width));
      }
      if ( $scope.sequence.blocks.length == 0 ) {
        $scope.sequence.blocks.push("");
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

    $scope.ape_upload = function() {

      var f = document.getElementById('ape-file').files[0],
          r = new FileReader();

      r.onloadend = function(e) {
        var data = e.target.result;

        $http.post("/sequences/" + $scope.sequence.id + "/upload.json", { file: data}).then(function(response) {
          console.log(response.data);
          if ( response.data.error ) {
            alert("Could not parse ape file: " + JSON.stringify(response.data.error) );
          } else {
            setup(response.data);
          }
        });

      }

      r.readAsBinaryString(f);

    }    

    $scope.location = function(feature) {
      var s = feature.sub.sequence_versions[0].data;
      var i = $scope.sequence.latest.data.indexOf(s);
      return [ i, i+s.length-1 ]
    }

    $scope.highlight_color = function(i) {
      var c = "highlight";
      aq.each($scope.sequence.features,function(f) {
        var r = $scope.location(f);
        if ( r[0] < i && i < r[1] ) {
          c += "-x";
        }
      });
      return c;
    }

  }]);

})();