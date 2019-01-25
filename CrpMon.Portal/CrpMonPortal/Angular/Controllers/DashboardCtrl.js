app.controller('DashboardCtrl', function ($rootScope, $scope, $http) {
    llamarData($http).Ganancia().then(function (response) {
        $scope.ModeloGanacia = response.data;
    }, function (error) {
        console.log(error);
    });

    llamarData($http).Vista().then(function (response) {
        $rootScope.ModeloVista = JSON.parse(response.data.ObjetoJson);

        llamarData($http).Producto().then(function (response) {
            $scope.ModeloProducto = response.data.producto;
            window.parent.$('.blocker').hide();
        }, function (error) {
            console.log(error);
        });
    }, function (error) {
        console.log(error);
    });

    $scope.Refrescar = function (e) {
        window.parent.$('.blocker').show();
        var tabStrip = window.parent.$('#tbsGeneral').data('kendoTabStrip');
        var tab = tabStrip.select();
        tabStrip.reload(tab);

        var tbsGeneralResp = window.parent.$('#tbsGeneralResp').data('kendoTabStrip');
        var tab = tbsGeneralResp.select();
        tbsGeneralResp.reload(tab);
    };

    $scope.Cerrar = function (e) {
        var tabStrip = window.parent.$('#tbsGeneral').data('kendoTabStrip');
        var tabResp = tabStrip.select();
        tabStrip.remove(tabResp);
        tabStrip.select(0);

        var tbsGeneralResp = window.parent.$('#tbsGeneralResp').data('kendoTabStrip');
        var tabResp = tbsGeneralResp.select();
        tbsGeneralResp.remove(tabResp);
        tbsGeneralResp.select(0);
    };
});

function llamarData($http) {
    return {
        Vista: consultarVista,
        Ganancia: consultarGanancias,
        Producto: consultarProducto
    }

    function consultarVista() {
        return $http.get(urlGlobal + 'Generales/Vista?pVista=Dashboard');
    }

    function consultarGanancias() {
        return $http.get(urlGlobal + 'Generales/Ganancias');
    }

    function consultarProducto() {
        return $http.get(urlGlobal + 'Perfil/Consultar');
    }
}