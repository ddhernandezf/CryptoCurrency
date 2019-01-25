var Schema = {
    NombreEstado: { type: "string" },
    NombreProducto: { type: "string" },
    ProductoImagen: { type: "string" },
    Consecutivo_Interno: { type: "number" },
    Transaccion_Monedero: { type: "string" },
    Monedero: { type: "number" },
    Observacion_1: { type: "string" },
    ID_Usuario: { type: "number" },
    Monedero_jsonResult: { type: "string" },
    Fecha_Hora: { type: "date" },
    Producto: { type: "number" },
    Estado: { type: "number" },
    Fecha_Ini: { type: "date" },
    Fecha_Fin: { type: "date" },
    Monedero_Amount: { type: "string" },
    Monedero_TimeOut: { type: "number" },
    Monedero_Status_Url: { type: "string" },
    Monedero_Qrcode_Url: { type: "string" },
    Monedero_Address: { type: "string" },
    TiempoAproximado: { type: "string" }
}

app.controller('TransaccionCtrl', function ($rootScope, $scope, $http) {
    $scope.Item = {
        NombreEstado: null,
        NombreProducto: null,
        ProductoImagen: null,
        Consecutivo_Interno: null,
        Transaccion_Monedero: null,
        Monedero: null,
        Observacion_1: null,
        ID_Usuario: null,
        Monedero_jsonResult: null,
        Fecha_Hora: null,
        Producto: null,
        Estado: null,
        Fecha_Ini: null,
        Fecha_Fin: null,
        Monedero_Amount: null,
        Monedero_TimeOut: null,
        Monedero_Status_Url: null,
        Monedero_Qrcode_Url: null,
        Monedero_Address: null,
        TiempoAproximado: null
    };
    $scope.msgError = null;
    $scope.IdInterval = null;

    llamarData($http).Vista().then(function (response) {
        $rootScope.ModeloVista = JSON.parse(response.data.ObjetoJson);

        llamarData($http).Transacciones().then(function (response) {
            $scope.kwnComprarOpt = {
                width: "300px",
                title: "Compra de paquetes",
                visible: false,
                modal: true,
                actions: []
            };

            $('#GestorPago').hide();
            $('#loader').hide();

            $scope.kgrdTranOpt = {
                toolbar: ["excel", "pdf"],
                excel: {
                    fileName: "Transacciones.xlsx",
                    filterable: true
                },
                pdf: {
                    allPages: true,
                    avoidLinks: true,
                    paperSize: "A4",
                    margin: { top: "2cm", left: "1cm", right: "1cm", bottom: "1cm" },
                    landscape: true,
                    repeatHeaders: true,
                    template: $("#page-template").html(),
                    scale: 0.8,
                    fileName: "Transacciones.pdf",
                },
                dataSource: {
                    data: response.data,
                    schema: {
                        model: {
                            fields: Schema
                        }
                    },
                    pageSize: 20
                },
                messages: {
                    commands: {
                        excel: $rootScope.ModeloVista.Columnas.btnExportXLS,
                        pdf: $rootScope.ModeloVista.Columnas.btnExportPDF
                    }
                },
                scrollable: true,
                sortable: true,
                filterable: true,
                pageable: true,
                selectable: "single",
                columns: getColumns($rootScope.ModeloVista.Columnas),
                dataBound: function (e) {
                    window.parent.$('.blocker').hide();
                },
                change: function (e) {
                    $scope.Item = this.dataItem(this.select());
                    if ($scope.Item.NombreEstado != 'Activo') {
                        $('#GestorPago').show();
                        $('#loader').hide();
                        $scope.msgError = $scope.Item.NombreEstado;

                        $scope.IdInterval = setInterval(function () {
                            $('#GestorPago').hide();
                            $('#loader').show();

                            $http.post(urlGlobal + 'Generales/ValidarTran?TransaccionId=' + $scope.Item.Transaccion_Monedero).then(function (response) {
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

                        $scope.$apply();

                        setTimeout(function () {
                            $scope.kwnComprar.title('Paquete ' + $scope.Item.NombreProducto);
                            $scope.kwnComprar.open();
                            $scope.kwnComprar.center();
                        }, 500);
                    }
                }
            };

            $scope.CerrarVentanaCompra = function (e) {
                $scope.kwnComprar.close();

                if ($scope.IdInterval != null) {
                    clearInterval($scope.IdInterval);
                }
            };

            setTimeout(function () {
                window.parent.$('.blocker').hide();
            }, 2500);
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
        Transacciones: consultarTransacciones
    }

    function consultarVista() {
        return $http.get(urlGlobal + 'Generales/Vista?pVista=Transaccion');
    }

    function consultarTransacciones() {
        return $http.get(urlGlobal + 'Transaccion/Consultar');
    }
}

function getColumns(data) {
    return [
        { field: "Transaccion_Monedero", title: data.Transaccion, width: "250px", filterable: { multi: true, search: true, search: true } },
        { field: "NombreProducto", title: data.Paquete, width: "100px", filterable: { multi: true, search: true, search: true } },
        { field: "NombreEstado", title: data.Estado, width: "100px", filterable: { multi: true, search: true, search: true } },
        { field: "Monedero_Amount", title: data.Monto, width: "100px" },
        { field: "Fecha_Ini", title: data.FTransaccion, width: "150px", template: "#=kendo.toString(Fecha_Ini, 'dd/MM/yyyy HH:mm:ss')#" },
        { field: "Fecha_Fin", title: data.FVencimiento, width: "150px", template: "#=kendo.toString(Fecha_Fin, 'dd/MM/yyyy HH:mm:ss')#" },
    ];
}