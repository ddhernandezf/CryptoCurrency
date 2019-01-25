app.controller('ProductoCtrl', function ($rootScope, $scope, $http) {
    $scope.ProductoCompra = null;
    $scope.ConfirmaCompra = null;
    $scope.msgError = null;
    $scope.IdInterval = null;

    llamarData($http).Productos().then(function (response) {
        $scope.klvProductoOpt = {
            selectable: "single",
            navigatable: true
        };

        $scope.kwnComprarOpt = {
            width: "300px",
            title: "Compra de paquetes",
            visible: false,
            modal: true,
            actions: []
        };

        $scope.kwnMensajeOpt = {
            width: "300px",
            title: "Alerta",
            visible: false,
            modal: true,
            actions: ["close"]
        };

        $scope.source = new kendo.data.DataSource({
            data: response.data
        });

        $scope.CargarProducto = function (e) {
            $scope.ProductoCompra = e;
            $scope.ConfirmaCompra = null;

            if ($scope.ProductoCompra.Monto <= MontoPaqueteActual) {
                $scope.kwnMensaje.open();
                $scope.kwnMensaje.center();
            }
            else {
                $scope.kwnComprar.title('Paquete ' + $scope.ProductoCompra.Descripcion);
                $scope.kwnComprar.open();
                $scope.kwnComprar.center();

                $('#GestorCompra').show();
                $('#GestorPago').hide();
                $('#loader').hide();
            }
        };

        $scope.CerrarVentanaCompra = function (e) {
            $scope.kwnComprar.close();

            if ($scope.IdInterval != null) {
                clearInterval($scope.IdInterval);
            }
        };

        $scope.Confirmacion = function (e) {
            $('#GestorCompra').hide();
            $('#GestorPago').hide();
            $('#loader').show();

            $http({
                method: 'POST',
                url: urlGlobal + 'Compra/Comprar',
                contentType: 'application/json; charset=utf-8',
                dataType: 'json',
                data: $scope.ProductoCompra
            }).success(function (data, status, headers, config) {
                if (typeof (data) === 'object') {
                    $scope.ConfirmaCompra = data;
                    $('#GestorPago').show();
                    $('#loader').hide();
                    $scope.msgError = 'Procesando su pago...';

                    $scope.IdInterval = setInterval(function () {
                        $('#GestorPago').hide();
                        $('#loader').show();

                        $http.post(urlGlobal + 'Generales/ValidarTran?TransaccionId=' + $scope.ConfirmaCompra.Transaccion_Monedero).then(function (response) {
                            try {
                                response.data = JSON.parse(response.data);
                                if (response.data == '"Complete"') {
                                    $scope.msgError = response.data;
                                    $('#GestorPago').show();
                                    $('#loader').hide();
                                }
                                else {
                                    $scope.msgError = response.data;
                                    $('#GestorPago').show();
                                    $('#loader').hide();
                                }
                            }
                            catch (err) {
                                $scope.msgError = 'Error en la comunicación del servidor';
                                $('#GestorPago').show();
                                $('#loader').hide();
                            }
                        }, function (error) {
                            $scope.msgError = error.data;
                            $('#GestorPago').show();
                            $('#loader').hide();
                        });
                    }, 15000);
                }
                else {
                    $scope.msgError = data;
                }
            }).error(function (data, status, headers, config) {
                $scope.msgError = data;
            });
        };

        setTimeout(function () {
            window.parent.$('.blocker').hide();
        }, 2500);
    }, function (error) {
        $scope.msgError = error.data;
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
});

function llamarData($http) {
    return {
        Vista: consultarVista,
        Productos: consultarProductos
    }

    function consultarVista() {
        return $http.get(urlGlobal + 'Generales/Vista?pVista=Compras');
    }

    function consultarProductos() {
        return $http.get(urlGlobal + 'Compra/ListarProductos');
    }
}