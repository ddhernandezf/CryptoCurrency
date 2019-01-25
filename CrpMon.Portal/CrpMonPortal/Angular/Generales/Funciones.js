function kdlIdioma($http, $scope, dataSource, valueSelected) {
    $scope.kddIdiomaDS = dataSource;
    $scope.kddIdiomaOPC = {
        dataTextField: "Descripcion",
        dataValueField: "Idioma",
        valueTemplate: '<span class="k-state-default" style="float: left; padding-left: 5px; padding-top: 0px;"><img style="height: 30px;" ng-src="{{dataItem.Imagen}}" /></span>' +
                  '<span class="k-state-default" style="float: left;margin-left: 5px;padding-top: 5px;">{{dataItem.Descripcion}}</span>',
        template: '<span class="k-state-default" style="float: left; padding-left: 5px; padding-top: 0px;"><img style="height: 30px;" ng-src="{{dataItem.Imagen}}" /></span>' +
                  '<span class="k-state-default" style="float: left;margin-left: 5px;padding-top: 5px;">{{dataItem.Descripcion}}</span>',
        value: valueSelected,
        select: function (e) {
            $('.blocker').show();

            $http.post(urlGlobal + 'Generales/CambiarIdioma?pIdioma=' + this.dataItem(e.item).Idioma).then(function (response) {
                location.reload();
            }, function (error) {
                console.log(error);
            });
        }
    };
}