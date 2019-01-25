app.controller('RedCtrl', function ($rootScope, $scope, $http) {
    $scope.ModeloPorcentaje = null;
    $scope.ModeloActual = null;
    $scope.MensajePendientePago = 'Aún no adquiere un paquete';

    llamarData($http).Porcentaje().then(function (response) {
        $scope.ModeloPorcentaje = response.data;

        llamarData($http).Arbol().then(function (response) {
            console.log(response.data);

            $scope.ModeloActual = response.data[0];

            $scope.kwnNodoOpt = {
                width: "300px",
                title: "Información del nodo",
                visible: false,
                modal: true,
                actions: ["close"]
            };

            $scope.kdmOpt = {
                zoom: 0.5,
                zoomable: true,
                editable: false,
                selectable: false,
                scrollable: true,
                dataSource: {
                    data: response.data,
                    schema: {
                        model: {
                            children: 'items'
                        }
                    }
                },
                layout: {
                    type: "tree",
                    subtype: "down",
                    horizontalSeparation: 40,
                    verticalSeparation: 60,
                    alignItems: 'start'
                },
                shapeDefaults: {
                    visual: function (options) {
                        var dataviz = kendo.dataviz;
                        var g = new dataviz.diagram.Group({
                            autoSize: true
                        });
                        var dataItem = options.dataItem;

                        g.append(new dataviz.diagram.Rectangle({
                            width: 60,
                            height: 60,
                            stroke: {
                                width: 0
                            },
                            fill: {
                                color: '#fff'
                            }
                        }));

                        if (dataItem.nombres != 'Disponible') {
                            g.append(new dataviz.diagram.Image({
                                source: urlGlobal + "CrpMonPortal/Imagenes/Arbol/NodoActivo.png",
                                x: 1,
                                y: 3,
                                width: 59,
                                height: 50
                            }));
                        }
                        else {
                            g.append(new dataviz.diagram.Image({
                                source: urlGlobal + "CrpMonPortal/Imagenes/Arbol/NodoInactivo.png",
                                x: 1,
                                y: 3,
                                width: 59,
                                height: 50
                            }));
                        }

                        return g;
                    }
                },
                connectionDefaults: {
                    stroke: {
                        color: "#357ebd",
                        width: 1,
                    },
                    startCap: {
                        type: 'FilledCircle'
                    },
                    endCap: {
                        type: 'ArrowStart'
                    },
                    selectable: false,
                    type: 'polyline'
                },
                click: function (e) {
                    if (e.item.dataItem.nombres != 'Disponible') {
                        $scope.ModeloActual = e.item.dataItem;
                        $scope.$apply();

                        $scope.kwnNodo.open();
                        $scope.kwnNodo.center();
                    }
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

    llamarData($http).Vista().then(function (response) {
        $rootScope.ModeloVista = JSON.parse(response.data.ObjetoJson);
    }, function (error) {
        console.log(error);
    });

    $scope.kslDiagramZoom = $('#kslDiagramZoom').kendoSlider({
        min: 0,
        max: 100,
        smallStep: 10,
        largeStep: 50,
        showButtons: false,
        value: 50,
        change: function (e) {
            $('#kdmArbolAvl').data('kendoDiagram').zoom(e.value / 100);
        }
    }).data("kendoSlider");

    $("#btnPierna").kendoMobileButtonGroup({
        select: function (e) {
            $http.get(urlGlobal + 'Red/CambiarPierna?Pierna=' + e.index).then(function (response) {
            }, function (error) {
            });
        },
        index: intPierna
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
        Porcentaje: consultarPorcentaje,
        Arbol: consultarArbol
    }

    function consultarVista() {
        return $http.get(urlGlobal + 'Generales/Vista?pVista=Red');
    }

    function consultarPorcentaje() {
        return $http.get(urlGlobal + 'Generales/Porcentajes');
    }

    function consultarArbol() {
        return $http.get(urlGlobal + 'Red/Consultar');
    }
}