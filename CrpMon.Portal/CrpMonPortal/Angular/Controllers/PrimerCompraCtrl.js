app.controller("PrimerCompraCtrl", function ($rootScope, $scope, $http) {
    $scope.MensajeError = null;
    $rootScope.Producto = null;

    llamarData($http).Productos().then(function (response) {
        $scope.klvProductoOpt = {
            selectable: "single",
            navigatable: true
        };

        $scope.source = new kendo.data.DataSource({
            data: response.data
        });

        $('.blocker').hide();
    }, function (error) {
        console.log('error');
        $('.blocker').hide();
    });

    llamarData($http).Vista().then(function (response) {
        $rootScope.ModeloVista = JSON.parse(response.data.ObjetoJson);

        $('.blocker').hide();
    }, function (error) {
        console.log(error);
    });

    $scope.Comprar = function (e) {
        if ($rootScope.Producto == null) {
            $scope.MensajeError = "Debe seleccionar un producto.";
        }
        else {
            $('.blocker').show();
            $scope.MensajeError = null;

            $http.post(urlGlobal + 'Seguridad/Comprar', $rootScope.Producto).then(function (response) {
                if (response.data == 'true') {
                    $scope.MensajeError = null;
                    window.location.href = '../Home/Index';
                }
                else {
                    $('.blocker').hide();
                    $scope.MensajeError = response.data;
                }
            }, function (error) {
                $('.blocker').hide();
                $scope.MensajeError = 'Error: ' + status;
            });
        }
    };

    $scope.Cancelar = function (e) {
        $('.blocker').show();
        window.location.href = urlGlobal + 'Seguridad/CerrarSesion';
    };

    $scope.CargarProducto = function (e) {
        $rootScope.Producto = e;
    };
});

function llamarData($http) {
    return {
        Vista: consultarVista,
        Productos: consultarProducto
    }

    function consultarVista() {
        return $http.get(urlGlobal + 'Generales/Vista?pVista=PrimerCompra');
    }

    function consultarProducto() {
        return $http.get(urlGlobal + 'Compra/ListarProductos');
    }
}