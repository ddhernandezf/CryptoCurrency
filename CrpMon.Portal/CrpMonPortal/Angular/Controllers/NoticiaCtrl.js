app.controller('NoticiaCtrl', function ($rootScope, $scope, $http) {
    $scope.Modelo = null;

    llamarData($http).Noticia().then(function (response) {
        $scope.Modelo = response.data;

        setTimeout(function () {
            window.parent.$('.blocker').hide();
        }, 2500);
    }, function (error) {
        console.log(error);
    });

    llamarData($http).Vista().then(function (response) {
        $rootScope.ModeloVista = JSON.parse(response.data.ObjetoJson);
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
        Noticia: consultarNoticia
    }

    function consultarVista() {
        return $http.get(urlGlobal + 'Generales/Vista?pVista=Noticias');
    }

    function consultarNoticia() {
        return $http.get(urlGlobal + 'Noticias/Consultar');
    }
}