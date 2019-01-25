app.directive("compareTo", function () {
    return {
        require: "ngModel",
        scope: {
            otherModelValue: "=compareTo"
        },
        link: function (scope, element, attributes, ngModel) {

            ngModel.$validators.compareTo = function (modelValue) {
                return modelValue == scope.otherModelValue.$modelValue;
            };

            scope.$watch("otherModelValue", function () {
                ngModel.$validate();
            });
        }
    };
});

app.controller('PerfilCtrl', function ($rootScope, $scope, $http) {
    $scope.PerfilModelo = null;
    $scope.CPassModelo = null;
    $scope.CDataModelo = null;
    $scope.PaqueteModelo = null;
    $scope.frmCambiarPassError = null;
    $scope.frmCambiarInfoError = null;

    llamarData($http).Perfil().then(function (response) {
        $scope.PerfilModelo = response.data.persona;
        $scope.CPassModelo = response.data.cambiarpassword;
        $scope.CDataModelo = response.data.cambiarperfil;
        $scope.PaqueteModelo = response.data.producto;

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
        var tabResp = tbsGeneralResp.select();
        tbsGeneralResp.reload(tabResp);
    };

    $scope.Cerrar = function (e) {
        var tabStrip = window.parent.$('#tbsGeneral').data('kendoTabStrip');
        var tab = tabStrip.select();
        tabStrip.remove(tab);
        tabStrip.select(0);

        var tbsGeneralResp = window.parent.$('#tbsGeneralResp').data('kendoTabStrip');
        var tabResp = tbsGeneralResp.select();
        tbsGeneralResp.remove(tabResp);
        tbsGeneralResp.select(0);
    };

    $scope.CambiarPassword = function (e) {
        window.parent.$('.blocker').show();

        $http.post(urlGlobal + 'Perfil/CambiarPassword', $scope.CPassModelo).then(function (response) {
            response.data = JSON.parse(response.data);
            if (response.data == 'OK') {
                window.parent.location.href = urlGlobal + 'Seguridad/CerrarSesion';
            }
            else {
                $scope.frmCambiarPassError = response.data;
            }
            window.parent.$('.blocker').hide();
        }, function (error) {
            $scope.frmCambiarPassError = error.data;
            window.parent.$('.blocker').hide();
        });
    };

    $scope.CambiarInfo = function (e) {
        window.parent.$('.blocker').show();

        $http.post(urlGlobal + 'Perfil/CambiarDatos', $scope.CDataModelo).then(function (response) {
            response.data = JSON.parse(response.data);
            if (response.data == 'OK') {
                window.location.reload();
            }
            else {
                $scope.frmCambiarInfoError = response.data;
            }
            window.parent.$('.blocker').hide();
        }, function (error) {
            $scope.frmCambiarInfoError = error.data;
            window.parent.$('.blocker').hide();
        });
    };
});

function llamarData($http) {
    return {
        Vista: consultarVista,
        Perfil: consultarPerfil,
    }

    function consultarVista() {
        return $http.get(urlGlobal + 'Generales/Vista?pVista=Perfil');
    }

    function consultarPerfil() {
        return $http.get(urlGlobal + 'Perfil/Consultar');
    }
}