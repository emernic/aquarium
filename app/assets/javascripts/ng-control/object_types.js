(function() {

  var w;
 
  try {
    w = angular.module('aquarium'); 
  } catch (e) {
    w = angular.module('aquarium', ['ngCookies','ui.ace']); 
  } 

  w.controller('objectTypesCtrl', [ '$scope', '$http', '$attrs', '$cookies', '$sce', 
                         function (  $scope,   $http,   $attrs,   $cookies,   $sce ) {

    AQ.init($http);
    AQ.update = () => { $scope.$apply(); }
    $scope.errors = [];

    AQ.ObjectType.all().then((object_types) => {
      $scope.object_types = object_types;
      $scope.handlers = aq.uniq(aq.collect(object_types,(ot) => { return ot.handler; }));
      $scope.current_handler = $scope.handlers[0];
      $scope.$apply();
    }).catch((e) => {
      $scope.errors.push("Could not retrieve object type list!")
    });

  }]);

})();
