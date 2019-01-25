app.controller("ConfirmarCtrl", function ($rootScope, $scope, $http) {
    $scope.msgError = 'Procesando su pago...';

    llamarData($http).Informacion().then(function (response) {
        $rootScope.Data = response.data;

        setTimeout(function () {
            $('.blocker').hide();
        }, 2500);
    }, function (error) {
        console.log('error');
        $('.blocker').hide();
    });

    llamarData($http).Vista().then(function (response) {
        $rootScope.ModeloVista = JSON.parse(response.data.ObjetoJson);
    }, function (error) {
        console.log(error);
    });

    Caller($scope, $http);
});

function llamarData($http) {
    return {
        Vista: consultarVista,
        Informacion: consultarInformacion
    }

    function consultarVista() {
        return $http.get(urlGlobal + 'Generales/Vista?pVista=ConfirmaCompra');
    }

    function consultarInformacion() {
        return $http.get(urlGlobal + 'Seguridad/InfoConfirmar');
    }
}

function Caller($scope, $http) {
    setInterval(function () {
        $('.blocker').show();

        $http.post(urlGlobal + 'Seguridad/ValidarTran').then(function (response) {
            try {
                response.data = JSON.parse(response.data);
                if (response.data == '"Complete"') {
                    $scope.msgError = response.data;
                    window.location.href = '../Home/Index';
                }
                else {
                    $scope.msgError = response.data;
                    setTimeout(function () {
                        $('.blocker').hide();
                    }, 500);
                }
            }
            catch (err) {
                $scope.msgError = 'Error en la comunicación del servidor';
                setTimeout(function () {
                    $('.blocker').hide();
                }, 500);
            }
        }, function (error) {
            $scope.msgError = error.data;
            setTimeout(function () {
                $('.blocker').hide();
            }, 500);
        });
    }, 15000);
}